Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1Vkxjp-00008V-H9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 15:06:13 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vkxjn-0002Fb-Io for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 15:06:13 +0000
Message-ID: <52936758.405@panasas.com>
Date: Mon, 25 Nov 2013 17:06:00 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <20131122060223.GP9991@yliu-dev.sh.intel.com>
	<CAFLxGvynVV=aY755xTPTa7-57O25Dwzc+cbWELj+4xxFKznKMg@mail.gmail.com>
	<52935F73.4090209@panasas.com> <2845101.Wgsx5afvdX@sandpuppy>
In-Reply-To: <2845101.Wgsx5afvdX@sandpuppy>
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
To: Richard Weinberger <richard@nod.at>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 11/25/2013 04:43 PM, Richard Weinberger wrote:
<snip>
>> [It stopped to be very important for me since I stopped using
>>  UM very much. Ever since FC17 I'm unable to produce a running
>>  image. It just will not boot, an image that a kvm would. So
>>  very sad me, but no UML for me anymore.]
> 
> Sad to hear.
> Did you try one from http://fs.devloop.org.uk/?
> Just booted a FC18 on UML. Works fine.
> 

I just tried this exact one last week. (It gets stuck half way through boot)
Could you post me the .config file you used, and command line, and/or any
other info?

I would love to try again. I used a pretty defconfig based config
and my invocation blow: (Note that I use make KBUILD_OUTPUT=.build_um)

#!/bin/bash
#

UMDIR=/home/bharrosh/dev/um
ROOT_FS=$UMDIR/Fedora18-AMD64-root_fs-1
UBD_SWAP=ubd1=$UMDIR/swap_file-1
FS_LOCAL_MOUNT=$UMDIR/target_rootfs-1
LOCALHOST_TUN_IP=192.168.1.117

MEM=384M

# run this to install new um drivers into an image
um_mkkernel()
{
	mount -o loop$ROOT_FS_OFFSET $ROOT_FS $FS_LOCAL_MOUNT \
		&& make ARCH=um KBUILD_OUTPUT=.build_um INSTALL_MOD_PATH=$FS_LOCAL_MOUNT modules_install
	umount $FS_LOCAL_MOUNT
}

# run this to load a UML system
um_load()
{
	./.build_um/vmlinux ubd0=$ROOT_FS $UBD_SWAP eth0=tuntap,,,$LOCALHOST_TUN_IP mem=$MEM
}


> In the past we've had some issues with systemd-enabled distros.
> systemd uncovered problem in the UML tty driver.
> 
>> If you want to investigate. try doing a modprobe xor.ko on
>> a uml and see. since xor.ko is only built on demand for example
>> enabling exofs or object-layout-driver will select it. ,or MD-raid5.
> 
> Ok.
> 

Thanks
Boaz

> Thanks,
> //richard
> 


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

