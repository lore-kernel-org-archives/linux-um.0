Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjdVP-0005d4-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 04:00:15 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AjdVO-0006CW-Ru
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 04:00:15 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-6) with ESMTP id
	i0MC0AXl031309 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2004 13:00:10 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-5) with UUCP id
	i0MC0Ag9031306 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 13:00:10 +0100
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0MBmwnW012463
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2004 12:48:58 +0100
Received: (from kraxel@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id i0MBmw3K012462
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 12:48:58 +0100
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040122114858.GH11029@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [Sebastian.Koch@metatool.de: Re: ps u failed with signal
	8 (FPE)]
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
Date: Thu, 22 Jan 2004 12:48:58 +0100
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

"ps u" doesn't work in uml due to some values in /proc/meminfo being zero,
see below for details,

  Gerd

----- Forwarded message from Sebastian Koch <Sebastian.Koch@metatool.de> -----

Date: Thu, 22 Jan 2004 11:20:17 +0100 (MET)
From: Sebastian Koch <Sebastian.Koch@metatool.de>
Subject: Re: ps u failed with signal 8 (FPE)
To: Albert Cahalan <albert@users.sf.net>
cc: Sebastian Koch <Sebastian.Koch@metatool.de>,
   Gerd Knorr <kraxel@bytesex.org>
Importance: high
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.482720, version=0.15.13

I've found it.

The problem is that the proc file system of the UML shows a wrong
/proc/meminfo. Especially the MemTotal:

Achen:~ # p /proc/meminfo
MemTotal:            0 kB
MemFree:         33656 kB
Buffers:           752 kB
Cached:          19756 kB
SwapCached:          0 kB
Active:          12236 kB
Inactive:        10600 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:            0 kB
LowFree:         33656 kB
SwapTotal:      262136 kB
SwapFree:       262136 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:           5360 kB
Slab:             3264 kB
Committed_AS:    27144 kB
PageTables:        172 kB
VmallocTotal:   449516 kB
VmallocUsed:       184 kB
VmallocChunk:   449332 kB
Achen:~ #

This leeds to divide by zero in ps/output.c line 785 because the
kb_main_total == 0.


/* pp->vm_rss * 1000 would overflow on 32-bit systems with 64 GB memory */
static int pr_pmem(char *restrict const outbuf, const proc_t *restrict
const pp){
  unsigned long pmem = 0;
  pmem = pp->vm_rss * 1000ULL / kb_main_total;
  if (pmem > 999) pmem = 999;
  return snprintf(outbuf, COLWID, "%2u.%u", (unsigned)(pmem/10),
(unsigned)(pmem%10));
}

Do you want to setup a consistence check after reading the proc/meminfo ?

I will try to find out the problem in UML.

Best regards
Sebastian



On 20 Jan 2004, Albert Cahalan wrote:

> On Tue, 2004-01-20 at 10:46, Sebastian Koch wrote:
>
> > Probably this is a known bug.
>
> Nope. I've not seen this one.
>
> > If you need additional information regarding the UML-, host-kernel or
> > the root file system please let me know. I can provide a backtrace if someone
> > point me out where to set a breakpoint. To be honest I don't understand the
> > kernel FPE signal handling at this moment.
>
> This could be caused by integer division by zero.
> If you can get the siginfo data, that would be
> enough to determine this.
>
> Also, try this:   ps --info
>
>
>

--



----- End forwarded message -----

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
