Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzD8E-0004Ey-7h for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 04:09:14 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzD89-0007bd-Hj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 04:09:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] strace of 'ls' under Fedora Core 3
References: <A06801158AE07847B27A52C1A074BC1D0725A4D6@fmsmsx404.amr.corp.intel.com>
	<200502101226.47978.blaisorblade@yahoo.it>
	<55690.80.203.9.134.1108035741.squirrel@80.203.9.134>
In-Reply-To: <55690.80.203.9.134.1108035741.squirrel@80.203.9.134>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101308.01931.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 13:08:01 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: stian@nixia.no, "Wichmann, Mats D" <mats.d.wichmann@intel.com>, Marion Bates <mbates@whoopis.com>, William Stearns <wstearns@pobox.com>

On Thursday 10 February 2005 12:42, stian@nixia.no wrote:
> > Also, the code inside UML should absolutely support it (from the code I
> > don't
> > see any problem), at least for the x86 UML.
>
> modify_ldt is a x86 syscall aswell, so it will only appear in x86/x86_64
> umls.
Yes, agreed... x86 UML supports it, but x86_64 UML does not (yet). I maybe was 
not clear that this is a missing feature, or a bug, or a 
put-another-name-for-ants-wasps-and-such-here.

Jeff stated that in 64-bit UML the 32-bit compatibility code is still gross 
(in fact he hasn't yet started merging it).

However, the GDT/LDT on x86_64 have a reduced role.... maybe they are 
supported in the 32-bit userspace / 64-bit kernel case, but surely not for 
the pure 64-bit case (wonder how TLS is done there).
> It was implemented and used by dosemu project originally. 

> What actually uses this syscall as I find the syscall to be badly
> documented last time I looked at it.
The TLS code... (Thread Local Storage).

In short, if you put a certain value in the (let's say) ES (or FS, or GS) 
register (they are segment selectors), it can point to an entry in the LDT 
(which you create with modify_ldt).

It means that if I read the address NNNN inside the ES segment (in assembler 
ES:NNNN in Intel notation), it will point to the NNNN address inside the 
segment (i.e. you have one "base address" to add to NNNN which can be != 0). 
Normal reads are done from the DS (for Data) and CS (for code) segments.

Now, if you switch the entry number in ES for each thread (probably this is 
done at startup and we rely on nobody else modifying the ES value, which is a 
valid guarantee), you get that each thread, with ES:NNNN, will access a 
different var (by creating one area for each thread and putting the base 
addresses of these areas inside various LDT entries).

I can confirm glibc uses modify_ldt() for TLS support on LinuxThreads. With 
NPTL, they use 2.6 host kernel support - instead of having 8192 maximum 
thread number (because this is the size of the LDT), one entry of the GDT is 
used, and for each task the kernel saves the appropriate segment descriptor.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
