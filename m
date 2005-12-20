Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eoo38-0000VV-24 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:25:30 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eoo37-0006F0-CV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:25:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <Pine.LNX.4.63.0510161818210.10902@ligur.student.mh.se>
	<20051215201530.GA10705@ccure.user-mode-linux.org>
	<200512161703.14319.blaisorblade@yahoo.it>
In-Reply-To: <200512161703.14319.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512202123.34630.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Bug in COW format - 64-bit incompatible with 32-bit
	due to struct padding (was: Re: [uml-user] uml_moo and large files)
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
Date: Tue, 20 Dec 2005 21:23:33 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Joel Palmius <joel.palmius@miun.se>

On Friday 16 December 2005 17:03, Blaisorblade wrote:
> On Thursday 15 December 2005 21:15, Jeff Dike wrote:
> > On Thu, Dec 15, 2005 at 05:26:44PM +0100, Blaisorblade wrote:

> We want a utility read-wrong-V3-header / write right one.

I have this support - indeed I've integrated the code to recognize (as 
suggested below) and read correctly a 64-bit V3 COW. This means that:

a) uml_moo will safely read 64-bit V3 COW and emit a warning
b) the fixed Uml kernel will do a transparent conversion (and emit the same 
warning). But it will also modify the files.

So we need an utility doing just the setup and the writeout. Should be easy to 
do, but I must learn the complete COW API. I will dismiss this task if I see 
(as it seems) that there are no existing COW files.

> At that point (see below) 64-bit buggy programs (uml_moo and kernel) will
> crash (SIGFPE) on correct V3 COWs. (And unlike real cows, crashing on COWs
> doesn't hurt the obstacle).

I've also tested the reverse case - uml_moo complains "Stating backing file: 
No such file or directory" - it doesn't find the backing file because of the 
leading zeros I described in the the ->backing_file field:

> c) it should be possible

Indeed this works.

> to distinguish between broken 64-bit and 32-bit V3 
> files, with the following line:
>
> if ( *((int*)header->backing_file) == 0)
> 	printf("Hey, broken V3 file with 64-bit\n");

> Broken 64-bit has 4 bytes of extra padding after ->mtime and before ->size:

In this I was wrong - this happens only in the kernel (which has __u32 mtime). 
The original V3 header uses time_t, which is a long (64-bit). Jeff Dike 
(IIRC) fixed this in the kernel, but didn't note the alignment. So I 
additionally used __u32 for mtime.

> struct cow_header_v3 {
>         __u32 magic;
>         __u32 version;
>         time_t mtime;
>         __u64 size;
>         __u32 sectorsize;
>         __u32 alignment;
>         __u32 cow_format;
>         char backing_file[PATH_LEN_V3];
> };
> == Fig. 1 - cow_header_v3 layout (for easier reference) ==

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
