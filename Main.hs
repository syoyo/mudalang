module Main where


import System.IO ( stdin, hGetContents )
import System.Environment ( getArgs, getProgName )
import System.Console.GetOpt
import System.FilePath
import Data.Maybe ( fromMaybe )

import LexMUDA
import ParMUDA
import SkelMUDA
import PrintMUDA
import AbsMUDA
import ErrM

import qualified IR
import qualified CodeGenSSE
import qualified CodeGenAVX
import qualified CodeGenVMX
import qualified CodeGenLLVM
import qualified CodeGenNEON
import qualified Syntax
import qualified Simplify
import qualified NameSpace
import qualified Sym


data CodeGenBackend =   SSE2Backend  -- x86/SSE2
                      | SSE4Backend  -- x86/SSE4            -- TODO
                      | SSE5Backend  -- AMD SSE5            -- TODO?
                      | AVXBackend   -- Intel AVX           -- TODO?
                      | VMXBackend   -- PPC/VMX(AltiVec)
                      | SPEBackend   -- Cell/SPE            -- TODO?
                      | CBackend     -- Plain C code        -- TODO?
                      | LLVMBackend  -- LLVM IR(.ll)       
                      | NEONBackend  -- ARM NEON
                        deriving (Show, Eq)

getCodeGenName :: CodeGenBackend -> String
getCodeGenName cg = case cg of
  SSE2Backend  -> "sse"
  SSE4Backend  -> "sse"
  SSE5Backend  -> "sse"
  AVXBackend   -> "avx"
  VMXBackend   -> "vmx"
  SPEBackend   -> "spe"
  CBackend     -> "c"
  LLVMBackend  -> "llvm"
  NEONBackend  -> "neon"

--
-- For command option handling
--

data MUDAFlag       =   Version
                      | Output  String
                      | Input   String
                      | Debug
                      | NoHeader
                      | NoIntrinsicHeader
                      | Backend CodeGenBackend
                        deriving (Show, Eq)

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

type Verbosity = Int

putStrV :: Verbosity -> String -> IO ()
putStrV v s = if v > 1 then putStrLn s else return ()


writeMUDACodeHeader :: String -> String -> IO ()
writeMUDACodeHeader fname str =
  writeFile fname str

parseTree :: CodeGenBackend -> [MUDAFlag] -> ParseFun AbsMUDA.Prog -> String -> String -> IO ()
parseTree b flags p s baseName =

  let ts = myLLexer s in case p ts of

           Bad s    -> do putStrLn "\nParse              Failed...\n"
                          -- putStrLn "Tokens:"
                          -- putStrLn $ show ts
                          putStrLn s
           Ok tree  -> do -- putStrLn $ CodeGenSSE.printTree $ IR.convProg tree

                          let ir = IR.convProg tree
                          let ir' = Syntax.checkSyntax ir

                          if (any (Debug ==) flags)
                            then do putStrLn "/*"
                                    putStrLn $ show ir'
                                    putStrLn "*/\n\n"
                            else do return ()

                          let ir'' = Simplify.simplifyTree ir'

                          if (any (Debug ==) flags) 
                            then do putStrLn "/* simplifyed:"
                                    putStrLn $ show ir''
                                    putStrLn "*/\n\n"
                            else do return ()

                          putStrLn $ emitStr b ir''

                          if (any (NoHeader ==) flags)
                            then do return ()
                            else do  writeFile (baseName ++ ".h") (emitHeaderStr b ir'')

                          if (any (NoIntrinsicHeader ==) flags)
                            then do return ()
                            else do  writeFile ("mudaintrin_" ++ getCodeGenName b ++ ".h") (emitIntrinHeaderStr b)

                       where

                         emitStr b ir = case b of

                          SSE2Backend  -> CodeGenSSE.printTree ir
                          VMXBackend   -> CodeGenVMX.printTree ir
                          LLVMBackend  -> CodeGenLLVM.printTree ir
                          AVXBackend   -> CodeGenAVX.printTree ir
                          NEONBackend  -> CodeGenNEON.printTree ir

                         emitHeaderStr b ir = case b of

                          SSE2Backend  -> CodeGenSSE.printHeader ir
                          VMXBackend   -> CodeGenVMX.printTree ir
                          LLVMBackend  -> CodeGenLLVM.printTree ir
                          AVXBackend   -> CodeGenAVX.printHeader ir
                          NEONBackend   -> CodeGenNEON.printHeader ir

                         emitIntrinHeaderStr b = case b of

                          SSE2Backend  -> CodeGenSSE.printIntrinsicHeader
                          AVXBackend   -> CodeGenAVX.printIntrinsicHeader
                          -- VMXBackend   -> CodeGenVMX.printIntrinsicHeader
                          LLVMBackend  -> CodeGenLLVM.printIntrinsicHeader
                          NEONBackend  -> CodeGenNEON.printIntrinsicHeader

runFile :: CodeGenBackend -> [MUDAFlag] -> Verbosity -> ParseFun AbsMUDA.Prog -> FilePath -> String -> IO ()
runFile b flags v p f n =

  do lines <- readFile f
     parseTree b flags p lines n


mudahOptions :: [OptDescr MUDAFlag]
mudahOptions =
  [ Option ['o']   ["output"]    (OptArg outp "FILE")            "output FILE"
  , Option ['v']   ["version"]   (NoArg Version)                 "show version"
  , Option ['s']   ["sse"]       (NoArg (Backend SSE2Backend))   "SSE2 backend"
  , Option ['p']   ["sse4"]      (NoArg (Backend SSE4Backend))   "SSE4 backend"
  , Option ['a']   ["avx"]       (NoArg (Backend AVXBackend))    "AVX backend"
  , Option ['m']   ["vmx"]       (NoArg (Backend VMXBackend))    "VMX backend"
  , Option ['l']   ["llvm"]      (NoArg (Backend LLVMBackend))   "LLVM backend"
  , Option ['e']   ["neon"]      (NoArg (Backend NEONBackend))   "NEON backend"
  , Option ['d']   ["debug"]     (NoArg Debug)                   "Debug"
  , Option ['n']   ["noheader"]  (NoArg NoHeader)                "do not emit header"
  , Option ['i']   ["nointrinheader"]  (NoArg NoIntrinsicHeader) "do not emit intrinsic header"
  ] 

inp, outp, headerp :: Maybe String -> MUDAFlag
inp     = Input  . fromMaybe "stdin"
outp    = Output . fromMaybe "stdout"
headerp = Output . fromMaybe "stdout"

mudahHeader = "Usage: mudah [OPTION...] files..."

mudahOpts :: [String] -> IO ([MUDAFlag], [String])
mudahOpts argv =
  case getOpt Permute mudahOptions argv of
    (o, n, []  ) -> return (o, n)
    (_, _, errs) -> ioError (userError (concat errs ++ usageInfo mudahHeader mudahOptions))



showTree :: (Show a, Print a) => Int -> a -> IO ()
showTree v tree
 = do
      putStrV v $ "\n[Abstract Syntax]\n\n" ++ show tree
      putStrV v $ "\n[Linearized tree]\n\n" ++ printTree tree


-- defaultBackend = SSE2Backend
defaultBackend = AVXBackend

version = "0.1"

getOutputName :: [MUDAFlag] -> Maybe String 
getOutputName [] = Nothing
getOutputName (f:fs) = getOutputName fs >>= proc f

  where
    
    proc :: MUDAFlag -> String -> Maybe String
    proc (Output str) prev = Just str
    proc _            prev = return prev


filterBackend :: MUDAFlag -> Bool
filterBackend f = case f of
  (Backend _) -> True
  _           -> False

getBackend :: [MUDAFlag] -> CodeGenBackend
getBackend fs = b

  where

    fs'   = filter filterBackend fs
    
    b     = if (length fs') == 0 then defaultBackend
                                 else getB (head fs')

    getB :: MUDAFlag -> CodeGenBackend
    getB (Backend b) = b 


procFile :: CodeGenBackend -> [MUDAFlag] -> String -> String -> IO ()
procFile b flags fname basename =
  runFile b flags 0 pProg fname basename

main :: IO ()
main = do (flags, args) <- getArgs >>= mudahOpts

          let inputName  = if (length args) == 0

                              then error (usageInfo mudahHeader mudahOptions)
                              else args !! 0    -- Use first element only


              baseName   = takeBaseName inputName
              backend    = getBackend   flags

          procFile backend flags inputName baseName


-- vim: set sw=4 ts=4 expandtab:
