Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAFLxGvymOuLznwat+4VdWPZJX4bJ=EecJwEezd_DgoRkm3FBTA@mail.gmail.com>
References: <CAKiyQA_p+wCCYEmsrau7X=V8mtcY1+MdpDX9RZz8PLB0sQHKuA@mail.gmail.com>
	<CAFLxGvymOuLznwat+4VdWPZJX4bJ=EecJwEezd_DgoRkm3FBTA@mail.gmail.com>
Date: Wed, 22 Aug 2012 19:34:40 +0300
Message-ID: <CAKiyQA_Lfiv8ex3+nRn+U386HPsgjo_iYB24kixDAwt7Qeuqng@mail.gmail.com>
From: Dragos Diaconescu <diaconescud@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5340908488470483992=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] TSC register
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

--===============5340908488470483992==
Content-Type: multipart/alternative; boundary=000e0ce0d25ed0a97004c7dd5121

--000e0ce0d25ed0a97004c7dd5121
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 22, 2012 at 5:39 PM, richard -rw- weinberger <
richard.weinberger@gmail.com> wrote:

> On Wed, Aug 22, 2012 at 3:23 PM, Dragos Diaconescu
> <diaconescud@gmail.com> wrote:
> > On an ubuntu kernel I used a busy waiting, with  ndelay function which
> uses
> > the TSC register, but
> > I have noticed that this register cannot be read from an UML.
>
> Please provide a test case.
>  I don't have yet a test case. What I want to do is to make a busy
> waiting, and interrupt this busy waiting
>
   at an interval of some nanoseconds and to use the ndelay function. I saw
that in the kernel implementation
   for the uml there is no "delay_tsc"
   function and there is only the "delay_loop" function. I am wondering why
the delay_tsc is not implemented. Is it not
   possible to read the TSC register?
   I would need this for having a nanosecond precision.

--
> Thanks,
> //richard
>

   Best wishes,

   Dragos

--000e0ce0d25ed0a97004c7dd5121
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 22, 2012 at 5:39 PM, richard=
 -rw- weinberger <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.weinberger=
@gmail.com" target=3D"_blank">richard.weinberger@gmail.com</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Aug 22, 2012 at 3:=
23 PM, Dragos Diaconescu<br>
&lt;<a href=3D"mailto:diaconescud@gmail.com">diaconescud@gmail.com</a>&gt; =
wrote:<br>
&gt; On an ubuntu kernel I used a busy waiting, with =A0ndelay function whi=
ch uses<br>
&gt; the TSC register, but<br>
&gt; I have noticed that this register cannot be read from an UML.<br>
<br>
</div>Please provide a test case.<br>
<span class=3D"HOEnZb"></span> I don&#39;t have yet a test case. What I wan=
t to do is to make a busy waiting, and interrupt this busy waiting<br></blo=
ckquote><div>=A0=A0 at an interval of some nanoseconds and to use the ndela=
y function. I saw that in the kernel implementation <br>
=A0=A0 for the uml there is no &quot;delay_tsc&quot; <br>=A0=A0 function an=
d there is only the &quot;delay_loop&quot; function. I am wondering why the=
 delay_tsc is not implemented. Is it not<br>=A0=A0 possible to read the TSC=
 register?<br>
=A0=A0 I would need this for having a nanosecond precision.<br><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888"=
>
--<br>
Thanks,<br>
//richard<br></font></span></blockquote><div><br>=A0=A0 Best wishes,<br><br=
>=A0=A0 Dragos <br></div></div><br>

--000e0ce0d25ed0a97004c7dd5121--


--===============5340908488470483992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============5340908488470483992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5340908488470483992==--


