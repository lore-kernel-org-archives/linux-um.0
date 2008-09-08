Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kcfcl-0006R1-Hi for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 05:13:43 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Kcfcj-00040J-WD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 05:13:43 -0700
Message-ID: <48C516CE.9000109@meduna.org>
Date: Mon, 08 Sep 2008 14:13:02 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
	<20080826174600.GA24342@c2.user-mode-linux.org>
	<48B44658.8010403@meduna.org>
	<20080826184425.GA18462@c2.user-mode-linux.org>
	<48B450C7.9090906@meduna.org>
In-Reply-To: <48B450C7.9090906@meduna.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Stanislav Meduna wrote:

>>> Same here with 2.6.26.2 :(
>>
>> Hmmm.  If it's not a problem there, I'm tempted to call it fixed,
>> whatever it was.  Can you check current 2.6.27-rc?
> 
> OK, I'll try to convince my provider to test 2.6.26.2 and
> possibly 27-rc soon - I'll let you know of the result.

Sorry for the late response. My provider compiled 2.6.26.3
and the problem is still here :(

I'll try to get the host config from him and to reproduce
it in a clean environment with the similar config as he has
(2.6.23.17 + skas3, i tried with current and without skas).
Is the skas3 patch still maintained?

He doesn't want to switch to SKAS4 yet, as it is marked
experimental and requires building from the same tree,
which he does not want.

-- 
                             Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
