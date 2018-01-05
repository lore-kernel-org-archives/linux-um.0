Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 05 Jan 2018 07:54:33 +0000
In-Reply-To: <1515136972-58532-1-git-send-email-weiyongjun1@huawei.com>
References: <1515136972-58532-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <79F1F2A3-B028-4330-9A77-4770D63AAE0D@kot-begemot.co.uk>
Subject: Re: [uml-devel] [PATCH -next] um: vector: fix missing unlock on
 error in vector_net_open()
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5568984511668144732=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Wei Yongjun <weiyongjun1@huawei.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

--===============5568984511668144732==
Content-Type: multipart/alternative; boundary="----17CVEPVQ15TY65UJVEBVZ1J3QG6QT6"
Content-Transfer-Encoding: 7bit

------17CVEPVQ15TY65UJVEBVZ1J3QG6QT6
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I think we have a similar patch pending=2E

Thanks for noticing=2E I will review and double check vs queued up patches=
=2E=20

A=2E=20

On 5 January 2018 07:22:52 GMT+00:00, Wei Yongjun <weiyongjun1@huawei=2Eco=
m> wrote:
>Add the missing unlock before return from function vector_net_open()
>in the error handling case=2E
>
>Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
>Signed-off-by: Wei Yongjun <weiyongjun1@huawei=2Ecom>
>---
> arch/um/drivers/vector_kern=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/arch/um/drivers/vector_kern=2Ec
>b/arch/um/drivers/vector_kern=2Ec
>index d1d5301=2E=2Ebb83a2d 100644
>--- a/arch/um/drivers/vector_kern=2Ec
>+++ b/arch/um/drivers/vector_kern=2Ec
>@@ -1156,8 +1156,10 @@ static int vector_net_open(struct net_device
>*dev)
> 	struct vector_device *vdevice;
>=20
> 	spin_lock_irqsave(&vp->lock, flags);
>-	if (vp->opened)
>+	if (vp->opened) {
>+		spin_unlock_irqrestore(&vp->lock, flags);
> 		return -ENXIO;
>+	}
> 	vp->opened =3D true;
> 	spin_unlock_irqrestore(&vp->lock, flags);

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------17CVEPVQ15TY65UJVEBVZ1J3QG6QT6
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>I think we have a similar patch pending=2E<br>
<br>
Thanks for noticing=2E I will review and double check vs queued up patches=
=2E <br>
<br>
A=2E <br><br><div class=3D"gmail_quote">On 5 January 2018 07:22:52 GMT+00:=
00, Wei Yongjun &lt;weiyongjun1@huawei=2Ecom&gt; wrote:<blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid =
rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">Add the missing unlock before return from function v=
ector_net_open()<br>in the error handling case=2E<br><br>Fixes: ad1f62ab2bd=
4 ("High Performance UML Vector Network Driver")<br>Signed-off-by: Wei Yong=
jun &lt;weiyongjun1@huawei=2Ecom&gt;<br>---<br> arch/um/drivers/vector_kern=
=2Ec | 4 +++-<br> 1 file changed, 3 insertions(+), 1 deletion(-)<br><br>dif=
f --git a/arch/um/drivers/vector_kern=2Ec b/arch/um/drivers/vector_kern=2Ec=
<br>index d1d5301=2E=2Ebb83a2d 100644<br>--- a/arch/um/drivers/vector_kern=
=2Ec<br>+++ b/arch/um/drivers/vector_kern=2Ec<br>@@ -1156,8 +1156,10 @@ sta=
tic int vector_net_open(struct net_device *dev)<br> 	struct vector_device *=
vdevice;<br> <br> 	spin_lock_irqsave(&amp;vp-&gt;lock, flags);<br>-	if (vp-=
&gt;opened)<br>+	if (vp-&gt;opened) {<br>+		spin_unlock_irqrestore(&amp;vp-=
&gt;lock, flags);<br> 		return -ENXIO;<br>+	}<br> 	vp-&gt;opened =3D true;<=
br> 	spin_unlock_irqrestore(&amp;vp-&gt;lock, flags);<br><br><br></pre></bl=
ockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E</=
body></html>
------17CVEPVQ15TY65UJVEBVZ1J3QG6QT6--


--===============5568984511668144732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============5568984511668144732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5568984511668144732==--


