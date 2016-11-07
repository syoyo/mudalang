unsigned long long
getcycle()
{
	unsigned long long val;

	// asm volatile ("cpuid; rdtsc" : "=A"(val));
	asm volatile ("rdtsc" : "=A"(val));

	return val;
}

