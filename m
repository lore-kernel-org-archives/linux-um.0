Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ6kU-0007Cy-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 08:43:22 -0700
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ6kU-0004Vt-5c for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 08:43:22 -0700
Message-ID: <40AA2F06.6020607@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.4.24-2 UML problems with hostfs ClearCase mounts
References: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 18 May 2004 11:43:02 -0400
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Thank you so much for the reply - For the most part existing hostfs 
support has been fine for me (I need the sync behaviour).

However with 2.4.24-1 I am still getting kernel panic crashes and it 
looked like some crashes were handled in 2.4.24-2. I will try to pick 
through the 2.4.24-2 patch and take just the not hostfs parts.

I do have loads of cores if anyone is interested since I hacked the 
panic code to abort() as I was not catching these intermittent crashes 
very often.

regards, Giovanni

Henrik Nordstrom wrote:
> On Mon, 17 May 2004, Joe Marzot wrote:
> 
> 
>>A little more data on this one - the behaviour I see with these mounts 
>>is that
>>
>>mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob
>>
>>succeeds but mounts the hosts / dir instead of the desired view extended 
>>pathname of the ClearCase vob.
> 
> 
> This is a known bug in 2.4.24-2. A patch can be found in the archives or 
> from http://marasystems.com/download/uml/
> 
> If you need hostfs then you should probably stick to 2.4.24-1 for the time
> being. Jeff is doing some heavy restructuring of the uml host file access
> methods while adding the humfs and as a result of this the hostfs support
> has become very unstable while the combined supporting framework for humfs
> and hostfs is taking shape. Hopefully this will soon result in a much 
> better hostfs than before, but at the moment things is a bit shaky..
> 
> Regards
> Henrik
> 
> 





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
