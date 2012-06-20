Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@dit.upm.es>) id 1ShOJU-0005yQ-5X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 17:03:28 +0000
Received: from mail.dit.upm.es ([138.4.2.7])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ShOJL-0001Ao-VG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 17:03:28 +0000
Message-ID: <4FE20217.2080101@dit.upm.es>
Date: Wed, 20 Jun 2012 19:02:15 +0200
From: =?ISO-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
MIME-Version: 1.0
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
	<CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
In-Reply-To: <CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] ubd option parsing problem when using cow
 filesystems in kernel 3.4
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 20/06/12 09:17, richard -rw- weinberger wrote:
> On Wed, Jun 20, 2012 at 12:33 AM, David Fern=E1ndez<david@dit.upm.es>  wr=
ote:
>> El 19/06/2012, a las 11:03, richard -rw- weinberger escribi=F3:
>>
>>> On Tue, Jun 19, 2012 at 10:55 AM, David Fern=E1ndez<david@dit.upm.es>  =
wrote:
>>>> Any idea of the cause of the problem? A simple 'diff' between 3.3 and
>>>> 3.4 versions shows the option parsing code has changed significantly.
>>> Can you do a git bisect?
>> I've some problems with git bisect, but I manage to make the tests manua=
lly and the result is:
> You have to bisect between v3.3 (Linus' tree) and v3.4-rc1.
> To make 3.4-rc1 compile you have to always to apply a fix.
> AFAIK the commit a3a85a763 (um: Disintegrate asm/system.h) fixes this.

Finally I managed to do the git bisect with your indications. The result:

# git bisect bad
026cee0086fe1df4cf74691cf273062cc769617d is the first bad commit
commit 026cee0086fe1df4cf74691cf273062cc769617d
Author: Pawel Moll <pawel.moll@arm.com>
Date:   Mon Mar 26 12:50:51 2012 +1030

     params: <level>_initcall-like kernel parameters

     This patch adds a set of macros that can be used to declare
     kernel parameters to be parsed _before_ initcalls at a chosen
     level are executed.  We rename the now-unused "flags" field of
     struct kernel_param as the level.  It's signed, for when we
     use this for early params as well, in future.

     Linker macro collating init calls had to be modified in order
     to add additional symbols between levels that are later used
     by the init code to split the calls into blocks.

     Signed-off-by: Pawel Moll <pawel.moll@arm.com>
     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

:040000 040000 f5622d1cb7f6933aa18fae3e30069d759deafc71 =

84f4f9747e3094c061308589b001c29c5d3234ab M    arch
:040000 040000 4809a8f0ac006bd718c16a33c987e593c4673654 =

4e6b5d41ce4ad1ea695463a95dfce5595181435d M    include
:040000 040000 36f9650000abe4d15d8859985f93bda1b8ef6cdf =

644e4fe5f6501505144dc0de6c8ff9b79d3b5d65 M    init
:040000 040000 edd20969e15db976a1923f3bc63315c5ff58eecf =

005f7039b2853d3f2571b50d695a4aaffbe4f1d0 M    kernel

An  the log:

# git bisect log
git bisect start
# good: [c16fa4f2ad19908a47c63d8fa436a1178438c7e7] Linux 3.3
git bisect good c16fa4f2ad19908a47c63d8fa436a1178438c7e7
# bad: [dd775ae2549217d3ae09363e3edb305d0fa19928] Linux 3.4-rc1
git bisect bad dd775ae2549217d3ae09363e3edb305d0fa19928
# good: [b2094ef840697bc8ca5d17a83b7e30fad5f1e9fa] Merge tag 'sound-3.4' =

of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good b2094ef840697bc8ca5d17a83b7e30fad5f1e9fa
# good: [1bfecd935849a45b6b47d9f011e1c278ff880512] Merge tag 'boards' of =

git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 1bfecd935849a45b6b47d9f011e1c278ff880512
# bad: [47b816ff7d520509176154748713e7d66b3ad6ac] Merge branch 'next' of =

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc
git bisect bad 47b816ff7d520509176154748713e7d66b3ad6ac
# good: [69e1aaddd63104f37021d0b0f6abfd9623c9134c] Merge tag =

'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect good 69e1aaddd63104f37021d0b0f6abfd9623c9134c
# good: [30304e5a79d424eb2c8707b3ff0e9b8bf6ab3e8f] Merge tag 'mfd_3.4-1' =

of git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6
git bisect good 30304e5a79d424eb2c8707b3ff0e9b8bf6ab3e8f
# bad: [d25413efa9536e2f425ea45c7720598035c597bc] Merge =

git://github.com/rustyrussell/linux
git bisect bad d25413efa9536e2f425ea45c7720598035c597bc
# good: [ade28abdcb474531bb7045c032a286812c7f6d2a] asus-wmi: don't =

update power and brightness when using scalar
git bisect good ade28abdcb474531bb7045c032a286812c7f6d2a
# good: [5430528b8bfa2c4d10df3bd59b73ab5faf6fa6cb] Merge branch =

'for_3.4/fixes/gpio-2' of =

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into =

gpio/next
git bisect good 5430528b8bfa2c4d10df3bd59b73ab5faf6fa6cb
# good: [61e5191c9d96268746bd57ed55d035678a1a2cf9] Merge branch =

'for_linus' of git://cavan.codon.org.uk/platform-drivers-x86
git bisect good 61e5191c9d96268746bd57ed55d035678a1a2cf9
# good: [0142877aa4e54dd9943fb727e9b386c36c8e3ab7] i5400_edac: Avoid =

calling pci_put_device() twice
git bisect good 0142877aa4e54dd9943fb727e9b386c36c8e3ab7
# bad: [f946eeb9313ff1470758e171a60fe7438a2ded3f] module: Remove module =

size limit
git bisect bad f946eeb9313ff1470758e171a60fe7438a2ded3f
# good: [8b8252813dee8e8cd453bb219731c36b268c69a7] module_param: remove =

support for bool parameters which are really int.
git bisect good 8b8252813dee8e8cd453bb219731c36b268c69a7
# bad: [d53799be6758841e1ffb1fd3780f73d0ffe44432] module: move =

__module_get and try_module_get() out of line.
git bisect bad d53799be6758841e1ffb1fd3780f73d0ffe44432
# bad: [026cee0086fe1df4cf74691cf273062cc769617d] params: =

<level>_initcall-like kernel parameters
git bisect bad 026cee0086fe1df4cf74691cf273062cc769617d

Let me know if you need any other test.

Best regards,
David




---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

