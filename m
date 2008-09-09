Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KdC92-0004wa-DI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Sep 2008 15:57:12 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KdC90-0003cn-Ia for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Sep 2008 15:57:12 -0700
Message-ID: <48C6FF00.4060304@meduna.org>
Date: Wed, 10 Sep 2008 00:56:00 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4898AC10.3010602@meduna.org>	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>	<48995D1A.6030203@meduna.org>
	<489AC525.3060305@meduna.org>	<489AE6DD.2000200@meduna.org>
	<489C3D9B.7070605@meduna.org>	<20080825215124.GB12626@c2.user-mode-linux.org>	<48B3AED8.5040904@meduna.org>	<20080826174600.GA24342@c2.user-mode-linux.org>	<48B44658.8010403@meduna.org>	<20080826184425.GA18462@c2.user-mode-linux.org>	<48B450C7.9090906@meduna.org>
	<48C516CE.9000109@meduna.org>
In-Reply-To: <48C516CE.9000109@meduna.org>
Content-Type: multipart/mixed; boundary="------------000705030707000902010508"
Subject: Re: [uml-devel] FP registers corruption
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Marek Zelem <marek@terminus.sk>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000705030707000902010508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stanislav Meduna wrote:

> I'll try to get the host config from him and to reproduce
> it in a clean environment with the similar config as he has
> (2.6.23.17 + skas3, i tried with current and without skas).
> Is the skas3 patch still maintained?

An update: I can definitely reproduce the problem using

- 2.6.23.17

- http://user-mode-linux.sourceforge.net/skas3-2.6.23.patch

- a patch from Marek Zelem that adds files missing
  from your patch (see attach)


Now we don't know whether the files added could cause
the problem - they were taken from a version a few weeks
older. There was following conversation between you
and Marek in June:

> > On Sun, Jun 22, 2008 at 03:37:12PM +0200, Marek Zelem wrote:
> >  I just want to inform you that skas3 patch available at
> > http://user-mode-linux.sourceforge.net/skas3-2.6.23.patch
> > does not contain new files (e.g. proc_mm.c, proc_mm.h, ...).

> Oops, thanks for letting me know.  I'm testing a fixed patch
> and will update the site when that's done.

Do you have the current version that applies cleanly
to the 2.6.23.17? I'd like to test with it before
declaring it as a definitive bug, it is well possible
that there was some hidden incompatibility.

Regards
-- 
                                 Stano

--------------000705030707000902010508
Content-Type: application/x-gzip;
 name="skas3-2.6.23.patch.new_files.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="skas3-2.6.23.patch.new_files.gz"

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
--------------000705030707000902010508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------000705030707000902010508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------000705030707000902010508--

