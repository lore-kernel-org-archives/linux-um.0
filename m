Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZ8Y2-0006By-AS
 for linux-um@lists.infradead.org; Fri, 07 Jun 2019 06:40:24 +0000
Subject: Re: [uml-devel] Running functions in SKAS
References: <MN2PR20MB283115FDE610524A87F975BECF170@MN2PR20MB2831.namprd20.prod.outlook.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e35cf47d-fbe8-962b-9bd7-31596523f1de@kot-begemot.co.uk>
Date: Fri, 7 Jun 2019 07:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <MN2PR20MB283115FDE610524A87F975BECF170@MN2PR20MB2831.namprd20.prod.outlook.com>
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



On 07/06/2019 00:27, Pablo Pessolani wrote:
> Hi:
>  =A0 =A0 =A0I need to run a custom (host-OS) system call=A0 from a user-s=
pace =

> process of a running UML (without been ptraced)
>  =A0 =A0 =A0The system call considers the host-OS /*task_struct*/, nor UM=
L =

> kernel allocated/*task_struct*/ for the process.
>  =A0 =A0 =A0So as not to break the UML operating mode, I think that could=
 I do =

> it running a function located in the process' SKAS stub and invoked from =

> the UML Kernel (such as /*stub_clone_handler*/())
>  =A0 =A0 =A0I there any way to do that? Can I define global/static variab=
les =

> in the process' SKAS stub?
> Regards.
> PAP
> =

> =

> =

> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> =

Changing to the current uml-mailing list.

That is one part of the code which has always been "and here be dragons" =

for me. My choice would be to do a device driver (f.e. char) and add map =

the relevant call onto an IOCTL.


-- =

Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

