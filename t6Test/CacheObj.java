
public class CacheObj
{
	int hits = 0;
	int misses = 0;
	
	int[][][] cache;
	int[][] tags;
	int[][] lruOrdering;
	int numberOfSets;
	int numberOfDirs;
	
	public CacheObj(int L, int K, int N)
	{
		cache = new int[N][K][L/4];
		tags = new int[N][K];
		for(int i = 0; i < N; i++)
			for (int j = 0; j < K; j++)
			{
				tags[i][j] = -1;
			}
		lruOrdering = new int[N][K];
		for(int i = 0; i < N; i++)
			for (int j = 0; j < K; j++)
			{
				lruOrdering[i][j] = K - j - 1; 
			}
		numberOfSets = N;
		numberOfDirs = K;
	}
	
	public void runWithAddresses(String[] addresses)
	{
		for(int i = 0; i < addresses.length; i++)
		{
			String currentAddress = addresses[i];
			int address = Integer.parseInt(addresses[i], 16);
			int offset = address & 15;
			int set = (address >> 4) & (int) (Math.pow(2, (Math.log(numberOfSets)/Math.log(2)))-1);
			//System.out.println(set);
			int tag = (address >> 4 + (int) (Math.log(numberOfSets)/Math.log(2)));
			//System.out.println("Offset = " + offset + ", Set = " + set + ", Tag = " + tag);
			int hitNum = getHitDirNum(tag, set, offset);
			if (hitNum != -1) //is Hit
			{
				this.hits++;
				this.updateLRUorder(set, hitNum);
			}
			else
			{
				this.misses++;
				int lruNum = this.getLRUDirNum(set);
				tags[set][lruNum] = tag;
				
				String start = addresses[i];
				start = start.substring(0, 3) + "0";
				int addrInt = Integer.parseInt(start, 16);
				//System.out.println(start);
				for(int j = 0; j < cache[set][lruNum].length; j++)
				{
					cache[set][lruNum][j] = addrInt;
					addrInt+=4;
				}
				
				this.updateLRUorder(set, lruNum);
			}
		}
	}
	
	public int getHitDirNum(int tag, int set, int offset)
	{
		for(int j = 0; j < numberOfDirs; j++)
		{
			if(tags[set][j] == tag)
			{
				return j;
			}
		}
		return -1;
	}
	
	public void updateLRUorder(int set, int dirNum)
	{
		if(this.lruOrdering[set][dirNum] == 0)
		{
			return;
		}
		if (this.lruOrdering[set][dirNum] == 1)
		{
			for (int i = 0; i < this.lruOrdering[set].length; i++)
			{
				if (this.lruOrdering[set][i] == 0)
					this.lruOrdering[set][i] = 1;
			}
			this.lruOrdering[set][dirNum] = 0;
			return;
		}
		this.lruOrdering[set][dirNum] = 0;
		for (int i = 0; i < this.lruOrdering[set].length; i++)
		{
			if (i == dirNum)
				continue;
			if(this.lruOrdering[set][i] == this.numberOfDirs-1)
				continue;
			this.lruOrdering[set][i]++;
		}
	}
	
	public int getLRUDirNum(int set)
	{
		for (int i = 0; i < this.lruOrdering[set].length; i++)
		{
			if (this.lruOrdering[set][i] == this.numberOfDirs - 1)
			{
				return i;
			}
		}
		return -1;
	}
	
	
	
}
