Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPkBi-0005du-53 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 08:37:58 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BPkBg-0001pC-A6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 08:37:56 -0700
Message-ID: <40A8DC43.5060001@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
References: <200405122208.i4CM8cCe008920@ccure.user-mode-linux.org>
	<40A3E217.2080104@nortelnetworks.com>
	<200405140143.i4E1hWZB005226@ccure.user-mode-linux.org>
	<40A4B26F.8080507@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4.24-2 UML problems with hostfs ClearCase mounts [ was
	Re: [uml-devel] uml-patch-2.4.24-3]
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
Date: Mon, 17 May 2004 11:37:39 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


A little more data on this one - the behaviour I see with these mounts 
is that

mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob

succeeds but mounts the hosts / dir instead of the desired view extended 
pathname of the ClearCase vob.

very strange - 2.4.24-1 patch seems to work fine with these Clearcase 
host filesystems.

I tries with 2.4.24-3 but did not even get it too boot but this is 
likely some other issue.

regards, GSM

Joe Marzot wrote:
> Jeff Dike wrote:
> 
>> gmarzot@nortelnetworks.com said:
>>
>>> I wonder based on what you say here if two UMLs that hostfs mount the
>>> same directory and access the same file...one for reading, and the
>>> other  for writing, if the first will see the updates written by the
>>> second....or maybe I am misinterpretting.
>>
>>
>>
>> You are correct, the writer will cache the new data, and the reader 
>> won't see
>> it until it's flushed out somehow.  If you can arrange to have the 
>> writer sync the filesystem before the reader reads the files, then it 
>> will get up-to-date information.
>>
>> Otherwise, if this is a problem, we need to make hostfs optionally 
>> synchronous.
> 
> 
> Yes - I think there is value in that.
> 
> On a different but related topic. I am trying the 2.4.24-2 patch to see 
> if it helps with the kernel panics I posted about in a previous thread 
> but I am now seeing some odd failures with hostfs. Granted my seetup is 
> a bit odd (i.e., atypical).
> 
> I am mounting Clearcase vobs using view extended pathnames. I have a 
> little script that mounts a whole series of Clearcase vobs...after the 
> script some are mounted and some are not...Clearcase implements these 
> view extended pathnames as a virtual filsystem (mvfs) and there must be 
> something about that which makes the mounting fail 
> occasionally...mouinting other host filesystems works as before. note: 
> mounting the CC mvfs vobs worked in 2.4.24-1 with no problem.
> 
> I will try again with 2.4.24-3 (w/ fsync - hopefully I can find the 
> right place(s)) and report on that...
> 
> regards, GSM
> 
>>
>>                 Jeff
>>
>>
> 
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
