Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <segooon@gmail.com>) id 1QnwEi-0007dP-3n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 17:25:04 +0000
Received: from mail-ey0-f171.google.com ([209.85.215.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QnwEh-0008Fa-71
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 17:25:04 +0000
Received: by eye22 with SMTP id 22so4724419eye.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 01 Aug 2011 10:24:57 -0700 (PDT)
Date: Mon, 1 Aug 2011 21:24:52 +0400
From: Vasiliy Kulikov <segoon@openwall.com>
Message-ID: <20110801172452.GA26190@albatros>
References: <201108011541.59640.richard@nod.at>
	<20110801134911.GA11705@albatros>
	<43e4e9e98b32d3d3eb06ab837a019ad8@localhost>
	<20110801171042.GA25954@albatros>
	<08cf4697685ecd9bcb7e4eefe516f2ee@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08cf4697685ecd9bcb7e4eefe516f2ee@localhost>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] shm updates broke UML
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: serge.hallyn@canonical.com, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, toralf.foerster@gmx.de, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Mon, Aug 01, 2011 at 19:19 +0200, Marc Zyngier wrote:
> Here you go (sorry about the line wrapping, damned webmail...):

Thank you!  Now I see that the problem is rw_mutex is not initialized:

	down_write(&shm_ids(ns).rw_mutex);

void __sched __down_write_nested(struct rw_semaphore *sem, int subclass)
{
    ...
	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
                                         ^^^^^^^^^^^^^^^ is NULL

Wtf - ipc namespace should be fully initialized for the moment of
threads run...

> Calibrating local timer... 104.99MHz.
> CPU1: Booted secondary processor
> CPU1: Unknown IPI message 0x1
> CPU2: Booted secondary processor
> CPU2: Unknown IPI message 0x1
> CPU3: Booted secondary processor
> CPU3: Unknown IPI message 0x1
> Brought up 4 CPUs
> SMP: Total of 4 processors activated (333.41 BogoMIPS).
> ns = c0447474, ids = c04474d0
> ns = c0447474, ids = c04474d0
> wait_list = c04474e0
> next =   (null)
           ^^^^^^

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. 
Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

