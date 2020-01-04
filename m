Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1inXBK-0007XM-Go
 for linux-um@lists.infradead.org; Sat, 04 Jan 2020 00:20:44 +0000
Subject: Re: Linux UM 5.4 FTBFS: uml_reserved undefined
References: <188c72613ff8b15454670dd9de68fefcaa130c74.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <cbf4ce06-d3a1-6931-44e4-7b0c737221ed@kot-begemot.co.uk>
Date: Sat, 4 Jan 2020 00:04:00 +0000
MIME-Version: 1.0
In-Reply-To: <188c72613ff8b15454670dd9de68fefcaa130c74.camel@researchut.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: rrs@researchut.com, linux-um@lists.infradead.org



On 02/01/2020 16:04, Ritesh Raj Sarraf wrote:
> Hi,
> 
> Happy New Year 2020.
> 
> When trying to prepare the 5.4 version of User Mode Linux for Debian, I
> have run into the following build failure on both the architectures.
> 
> For now, I have disabled VIRTIO_UML to get the new UML into Debian.
> 
> 
>    KSYM    .tmp_kallsyms2.o
>    LD      vmlinux
>    SYSMAP  System.map
>    LINK linux
>    Building modules, stage 2.
>    MODPOST 939 modules
> ERROR: "uml_reserved" [arch/um/drivers/virtio_uml.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make[1]: *** [Makefile:1298: modules] Error 2
> make[1]: Leaving directory '/build/user-mode-linux-5.4-1um/linux-source-5.4'
> make: *** [debian/rules:75: build-stamp] Error 2
> dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
> I: copying local configuration
> E: Failed autobuilding of package
> I: unmounting dev/pts filesystem
> I: unmounting dev/shm filesystem
> I: unmounting proc filesystem
> I: unmounting sys filesystem
> I: cleaning the build env

I think we disabled virtio as module because of other reasons as well 
later on. The patch is in the mailing list archive.

Brgds,

A.

> 
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

