Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzDgT-0005zc-Nb for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 04:44:37 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzDgQ-0002pb-39 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 04:44:37 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050121121532.GA22707@bytesex>
	<200501211407.09896.blaisorblade@yahoo.it>
	<20050209173336.GE14590@bytesex>
In-Reply-To: <20050209173336.GE14590@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101343.30345.blaisorblade@yahoo.it>
Subject: [uml-devel] Ported SKAS3-v7 (and partially -V8) for 2.6.11.
	Uncleanness about SYSEMU_SINGLESTEP
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
Date: Thu, 10 Feb 2005 13:43:29 +0100
To: Gerd Knorr <kraxel@bytesex.org>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 09 February 2005 18:33, Gerd Knorr wrote:
> > > Anyone looked at 2.6.11-rc1 for the host?  Some more ptrace cleanups
> >
> > I've already solved those conflict earlier on -rc1 (not tested) but I
> > didn't polish it out yet... if you are in a hurry, I can finish it and
> > post the result today on the ML. If not, I'll publish it later.
>
> Was busy with other stuff recently, but next days I plan to look at this
> again.  I've seen you released skas v8 meanwhile, but for 2.6.9 only.
> If you have a 2.6.11-rc patch as well already that would be very nice.
I've just done a -V7 for -rc3-bk6... I've called it -V7-rc1 because 
potentially something could go wrong (in general, and for this special 
kernel).

I've also added three patches from the V8-rc1 for 2.6.9 (so it's actually a 
-V7a: versioning is fscking up). I've not yet added the SYSEMU_SINGLESTEP 
support, because it seemed me a bit unclean even in 2.6.9, so even porting it 
cleanly to 2.6.10 is a bit hard (C. Aker did the porting, and , but in that 
form it is not up-to-date with the introduction of the set/clear_singlestep 
accessors).

The problem is that PTRACE_SYSEMU_SINGLESTEP is put together with 
PTRACE_SYSCALL, not with PTRACE_SINGLESTEP... I understand in 2.6.7 it maybe 
made sense (SINGLESTEP had a different behaviour then, problems when 
singlestepping syscalls) but it's unclean in 2.6.9 and does not port well to 
2.6.10, as said (... unless I miss something, I'm going to cleanup this for 
2.6.9 and for 2.6.10.

For 2.6.7 I would rawly use your version, unless I discovered any bugs during 
the cleanup (backporting cleanups is useless IMHO, unless for other reasons 
like keeping things in sync).
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
