module Report
import IO;
import Prelude;
import Common;

/*
 * Module Purpose: The Common module stores the report functionality
 */
 
 public void printReport(list [map[str, loc]] locationHashList, list[list[int]] mapping)
 {
 	println("---------------- Report ----------------");
	int scannedLOC = size(locationHashList);
	
	list[int] listItemSize = [];
	map[int, list[loc]] cloneSizeLocationMap = ();
	for (listItem <- mapping)
	{
		//println(listItem);
		int itemSize = size(listItem);
		if ( itemSize >= 3)
		{
			int beginLine = getLocationValue(locationHashList[listItem[0]]).begin.line;
			int endLine = getLocationValue(locationHashList[listItem[size(listItem) - 1]]).end.line;
			loc tmpLoc = toLocation(getLocationValue(locationHashList[listItem[0]]).uri);
			tmpLoc = customLocation(tmpLoc, beginLine, endLine);
			
			//iprintln(cloneSizeLocationMap);
			
			if (itemSize in cloneSizeLocationMap)
			{
				cloneSizeLocationMap[itemSize] = cloneSizeLocationMap[itemSize] + [tmpLoc];
			}
			else
			{
				cloneSizeLocationMap += (itemSize: [tmpLoc]);
			}
			if (itemSize notin listItemSize)
			{
				listItemSize += itemSize;
			}
		}
	}
	
	if (size(listItemSize) > 0)
	{
		listItemSize = sort(listItemSize);
		println("Number of clone classes :: <size(listItemSize)>");
		println("Biggest clone size (loc) :: <max(listItemSize)>");
		println("Total number of read lines :: <size(locationHashList)>");
		
		for (element <- listItemSize)
		{
			int sum = 0;
			println("--- Clone class of size <element> ---");
			for (item <- cloneSizeLocationMap[element])
			{
				sum += element;
			}
			sum = sum - element;
			println("The clone class ammount to <sum * 100.0 / size(locationHashList)> % of the SLOC");
			int counter = 1;
			for (item <- cloneSizeLocationMap[element])
			{
				println("<counter>: <item>");
				counter += 1;
			}
			println("-------------------------------------");
		}
	}
	else
	{
		println("No clones bigger than 3 lines of code were detected");
	}
 }