Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hLX4F-00022C-6E
 for linux-um@lists.infradead.org; Tue, 30 Apr 2019 18:01:25 +0000
Subject: Re: [uml-devel] How to convert UML user-space virtual address into
 HOST user-space virtual address?
References: <DM5PR2001MB17712DD834B1FE3447F1904ECF3A0@DM5PR2001MB1771.namprd20.prod.outlook.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <92895366-dab3-ffe4-877a-f6c9f90b9471@kot-begemot.co.uk>
Date: Tue, 30 Apr 2019 18:19:36 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR2001MB17712DD834B1FE3447F1904ECF3A0@DM5PR2001MB1771.namprd20.prod.outlook.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Pablo Pessolani <ppessolani@hotmail.com>, linux-um@lists.infradead.org



On 30/04/2019 16:38, Pablo Pessolani wrote:
> Hi:
>  =A0 =A0 I am writing a UML device driver wrapper (uml/drivers),=A0 and I=
 need =

> to convert=A0an address of a UML user-space process into an address of UM=
L =

> kernel space.
> =

> i.e.
> =

> Process_running_within_UML(){
>  =A0 =A0 =A0 =A0 =A0char uml_usr_buffer[MAXBUF];
>  =A0 =A0 =A0 =A0 =A0.....
> ret =3D ioctl(dvk_fd,DVK_IOCSDCINIT, (int) uml_usr_buffer);
> }
> =

> UML *ioctl()* syscall is translated by UML to os_ioctl_generic =

> <https://elixir.bootlin.com/linux/v4.9.88/ident/os_ioctl_generic>()  =

> which then calls host *ioctl().*
> =

> The *uml_usr_buffe*r address is a UML virtual address, not host virtual =

> address.
> I need to convert this UML user-space virtual address into user-space =

> HOST virtual address.

UML Kernel "phys" address =3D=3D Host kernel process user space address.

> *
> *
> Can I use, virt_to_phys() ??

Off the top of my head - Yes.

> *
> *
> *Thanks in advance.*
> *PAP*
> *
> *
> =

> =

> =

> =

> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> =


Switching to the new mailing list.
Best Regards,

-- =

Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

