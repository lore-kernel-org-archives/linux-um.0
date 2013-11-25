Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Vkxmy-0000MN-Ms
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 15:09:28 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vkxmt-00036g-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 15:09:28 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Nov 2013 16:09:13 +0100
Message-ID: <1438760.zvSCZ2cKYN@sandpuppy>
In-Reply-To: <52936758.405@panasas.com>
References: <20131122060223.GP9991@yliu-dev.sh.intel.com>
	<2845101.Wgsx5afvdX@sandpuppy> <52936758.405@panasas.com>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] WARNING: CPU: 0 PID: 1 at init/main.c:711
	do_one_initcall()
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Montag, 25. November 2013, 17:06:00 schrieb Boaz Harrosh:
> On 11/25/2013 04:43 PM, Richard Weinberger wrote:
> <snip>
> 
> >> [It stopped to be very important for me since I stopped using
> >> 
> >>  UM very much. Ever since FC17 I'm unable to produce a running
> >>  image. It just will not boot, an image that a kvm would. So
> >>  very sad me, but no UML for me anymore.]
> > 
> > Sad to hear.
> > Did you try one from http://fs.devloop.org.uk/?
> > Just booted a FC18 on UML. Works fine.
> 
> I just tried this exact one last week. (It gets stuck half way through boot)
> Could you post me the .config file you used, and command line, and/or any
> other info?

Just did (on x86_64):

$ make defconfig ARCH=um
$ make -j 4 linux ARCH=um
$ ./linux ubda=../Fedora18-AMD64-root_fs mem=512M

Thanks,
//richard

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

