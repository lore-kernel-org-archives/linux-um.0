Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzmyfzG-fx9BMzfO1gFjBjMnP0eJeGJN_B_Zj=EMe7r8Q@mail.gmail.com>
References: <CAKiyQA_p+wCCYEmsrau7X=V8mtcY1+MdpDX9RZz8PLB0sQHKuA@mail.gmail.com>
	<CAFLxGvymOuLznwat+4VdWPZJX4bJ=EecJwEezd_DgoRkm3FBTA@mail.gmail.com>
	<CAKiyQA_Lfiv8ex3+nRn+U386HPsgjo_iYB24kixDAwt7Qeuqng@mail.gmail.com>
	<CAFLxGvzmyfzG-fx9BMzfO1gFjBjMnP0eJeGJN_B_Zj=EMe7r8Q@mail.gmail.com>
Date: Fri, 24 Aug 2012 18:09:28 +0300
Message-ID: <CAKiyQA8syfUucN2YKo7vTS=M8T0wipnmdEGq0KDGhhj-oEWKfg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6340476101769701552=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] TSC register
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

--===============6340476101769701552==
Content-Type: multipart/alternative; boundary=000e0ce005fec32f8f04c8045c81

--000e0ce005fec32f8f04c8045c81
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 23, 2012 at 6:52 PM, richard -rw- weinberger <
richard.weinberger@gmail.com> wrote:

> On Wed, Aug 22, 2012 at 6:34 PM, Dragos Diaconescu
> <diaconescud@gmail.com> wrote:
> >    at an interval of some nanoseconds and to use the ndelay function. I
> saw
> > that in the kernel implementation
> >    for the uml there is no "delay_tsc"
> >    function and there is only the "delay_loop" function. I am wondering
> why
> > the delay_tsc is not implemented. Is it not
> >    possible to read the TSC register?
> >    I would need this for having a nanosecond precision.
>
> You can access TSC from user space, so also UML can read it.
> There is no delay_tsc() in UML because nobody cared so far.
> Feel free to implement it and send me a patch. :-)
>
>    I will try to implement a delay_tsc for UML andI will send you a patch.
Can you please
  give me some directions? Shall I implement in the same manner as is
implemented in
  /arch/x86/lib/delay.c . What are the big differences between this
implementation and in an implementation
  for UML?

 --
> Thanks,
> //richard
>

  Many thanks,

  Dragos

--000e0ce005fec32f8f04c8045c81
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Aug 23, 2012 at 6:52 PM, richard=
 -rw- weinberger <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.weinberger=
@gmail.com" target=3D"_blank">richard.weinberger@gmail.com</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Aug 22, 2012 at 6:=
34 PM, Dragos Diaconescu<br>
&lt;<a href=3D"mailto:diaconescud@gmail.com">diaconescud@gmail.com</a>&gt; =
wrote:<br>
&gt; =A0 =A0at an interval of some nanoseconds and to use the ndelay functi=
on. I saw<br>
&gt; that in the kernel implementation<br>
&gt; =A0 =A0for the uml there is no &quot;delay_tsc&quot;<br>
&gt; =A0 =A0function and there is only the &quot;delay_loop&quot; function.=
 I am wondering why<br>
&gt; the delay_tsc is not implemented. Is it not<br>
&gt; =A0 =A0possible to read the TSC register?<br>
&gt; =A0 =A0I would need this for having a nanosecond precision.<br>
<br>
</div>You can access TSC from user space, so also UML can read it.<br>
There is no delay_tsc() in UML because nobody cared so far.<br>
Feel free to implement it and send me a patch. :-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>=A0=A0 I will try to implement a delay_tsc for UML andI will send y=
ou a patch. Can you please<br>=A0 give me some directions? Shall I implemen=
t in the same manner as is implemented in <br>
=A0 /arch/x86/lib/delay.c . What are the big differences between this imple=
mentation and in an implementation<br>=A0 for UML?<br><br> </div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
Thanks,<br>
//richard<br>
</font></span></blockquote></div><br>=A0 Many thanks,<br><br>=A0 Dragos<br>

--000e0ce005fec32f8f04c8045c81--


--===============6340476101769701552==
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
--===============6340476101769701552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6340476101769701552==--


