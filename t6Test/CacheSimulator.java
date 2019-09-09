
public class CacheSimulator {

	public static void main(String[] args) 
	{
		CacheObj cache = new CacheObj(16,1,8);
		String[] addresses = {"0000","0004","000c","2200", "00d0", "00e0", "1130", "0028", "113c", "2204", "0010", "0020", "0004", "0040", "2208", "0008", "00a0", "0004", "1104", "0028", "000c", "0084", "000c", "3390", "00b0", "1100", "0028", "0064", "0070", "00d0", "0008", "3394"};                                                 
		cache.runWithAddresses(addresses);
		System.out.println("\nFor 128 byte 1-way cache with 16 bytes per line (direct mapped):\n   Hits = " + cache.hits + ", Misses = " + cache.misses + "\n");

		cache = new CacheObj(16,2,4);                                                 
		cache.runWithAddresses(addresses);
		System.out.println("For 128 byte 2-way set associative cache with 16 bytes per line:\n   Hits = " + cache.hits + ", Misses = " + cache.misses + "\n");

		cache = new CacheObj(16,4,2);                                                 
		cache.runWithAddresses(addresses);
		System.out.println("For 128 byte 4-way set associative cache with 16 bytes per line:\n   Hits = " + cache.hits + ", Misses = " + cache.misses + "\n");

		cache = new CacheObj(16,8,1);                                                 
		cache.runWithAddresses(addresses);
		System.out.println("For 128 byte 8-way associative cache with 16 bytes per line (fully associative):\n   Hits = " + cache.hits + ", Misses = " + cache.misses + "\n");


	}

}
