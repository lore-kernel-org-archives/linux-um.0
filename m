Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard.weinberger@gmail.com>) id 1PJ3Rj-0000BC-BJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 12:18:35 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PJ3Ri-0001eV-Fn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 12:18:35 +0000
Received: by yxd5 with SMTP id 5so1822310yxd.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 Nov 2010 04:18:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xJb1LcGXeCcd_tJ+Q9vV5W4z3M-up_mrKeV9q@mail.gmail.com>
References: <AANLkTi=xJb1LcGXeCcd_tJ+Q9vV5W4z3M-up_mrKeV9q@mail.gmail.com>
Date: Thu, 18 Nov 2010 13:18:28 +0100
Message-ID: <AANLkTim+sFEW6QWTMdyTGR66VKLio61v0Rxbm8Z6dy_e@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] [PATCH 1/2] uml: Safely iterate list of winch
	handlers in line driver.
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
To: Will Newton <will.newton@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 13, 2010 at 6:44 PM, Will Newton <will.newton@gmail.com> wrote:
> unregister_winch should use list_for_each_safe, as it can
> potentially delete from the list.
>
> Signed-off-by: Will Newton <will.newton@gmail.com>
> ---
> =A0arch/um/drivers/line.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 7f7338c..5f12fef 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -820,12 +820,12 @@ void register_winch_irq(int fd, int tty_fd, int
> pid, struct tty_struct *tty,
>
> =A0static void unregister_winch(struct tty_struct *tty)
> =A0{
> - =A0 =A0 =A0 struct list_head *ele;
> + =A0 =A0 =A0 struct list_head *ele, *next;
> =A0 =A0 =A0 =A0struct winch *winch;
>
> =A0 =A0 =A0 =A0spin_lock(&winch_handler_lock);
>
> - =A0 =A0 =A0 list_for_each(ele, &winch_handlers) {
> + =A0 =A0 =A0 list_for_each_safe(ele, next, &winch_handlers) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0winch =3D list_entry(ele, struct winch, li=
st);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (winch->tty =3D=3D tty) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_winch(winch, 1);
> --
> 1.7.0.4
>

Please send your patches to akpm.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

