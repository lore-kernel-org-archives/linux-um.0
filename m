Return-Path: <james_mcmechan@hotmail.com>
From: James McMechan <james_mcmechan@hotmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
Date: Mon, 20 Jan 2020 00:22:44 +0000
Message-ID: 
 <SN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
References: <20191210212108.222514-1-brendanhiggins@google.com>
 <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>,<CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
In-Reply-To: 
 <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR10MB3039E2FB633AC95CF4279B04E2320SN6PR10MB3039namp_"
MIME-Version: 1.0
To: Richard Weinberger <richard.weinberger@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "davidgow@google.com" <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

--_000_SN6PR10MB3039E2FB633AC95CF4279B04E2320SN6PR10MB3039namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I agree that at least the UML_NET_VECTOR is not compatible with static link=
ing at the moment,
but I was running a statically linked UML with PCAP back in December.
I was having no problems, but I don't remember if I was using PCAP itself..=
.
I seem to remember a minor patch I did to fix a symbol conflict but nothing=
 of note.
I have not played around with UML_NET_VECTOR since I run the normal network=
ing.
I did not find any config info when googling the vector version so I just i=
gnored it.

Enjoy.

Jim McMechan
________________________________
From: linux-um <linux-um-bounces@lists.infradead.org> on behalf of Richard =
Weinberger <richard.weinberger@gmail.com>
Sent: Sunday, January 19, 2020 1:40 PM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes.berg@intel.com>; Richard Weinberger <richard@no=
d.at>; Jeff Dike <jdike@addtoit.com>; linux-um <linux-um@lists.infradead.or=
g>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; davidgow@goog=
le.com <davidgow@google.com>; Brendan Higgins <brendanhiggins@google.com>; =
Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static

On Wed, Dec 11, 2019 at 9:40 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Brendan,
>
> On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> > be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> > UML_NET_PCAP; this is because glibc tries to load NSS which does not
> > support being statically linked. So make CONFIG_STATIC_LINK depend on
> > !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
> >
> > Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697=
@cambridgegreys.com/#t
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 2a6d04fcb3e91..1ddc8745123f2 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> >  config STATIC_LINK
> >         bool "Force a static link"
> > +       depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP
>
> "depends on !FORBID_STATIC_LINK"?
>
> Then all the drivers that are incompatible with static linking can just
> select FORBID_STATIC_LINK in their own Kconfig block.

Makes sense!

--
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--_000_SN6PR10MB3039E2FB633AC95CF4279B04E2320SN6PR10MB3039namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I agree that at least the&nbsp;<span style=3D"color: rgb(50, 49, 48); font-=
family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &qu=
ot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(255,=
 255, 255); display: inline !important">UML_NET_VECTOR
 is not compatible with static linking at the moment,</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">but
 I was running a statically linked UML with PCAP back in December.&nbsp;</s=
pan></div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
I was having no problems, but I don't remember if I was using PCAP itself..=
.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
I seem to remember a minor patch I did to fix a symbol conflict but nothing=
 of note.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
I have not played around with&nbsp;<span style=3D"color: rgb(50, 49, 48); f=
ont-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,=
 &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(=
255, 255, 255); display: inline !important">UML_NET_VECTOR
 since I run the normal networking.</span></div>
<div style=3D""><span style=3D"font-size: 14.6667px;">I did not find any co=
nfig info when googling the vector version so I just ignored it.</span></di=
v>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
Enjoy.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
Jim McMechan</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> linux-um &lt;linux-um=
-bounces@lists.infradead.org&gt; on behalf of Richard Weinberger &lt;richar=
d.weinberger@gmail.com&gt;<br>
<b>Sent:</b> Sunday, January 19, 2020 1:40 PM<br>
<b>To:</b> Geert Uytterhoeven &lt;geert@linux-m68k.org&gt;<br>
<b>Cc:</b> Johannes Berg &lt;johannes.berg@intel.com&gt;; Richard Weinberge=
r &lt;richard@nod.at&gt;; Jeff Dike &lt;jdike@addtoit.com&gt;; linux-um &lt=
;linux-um@lists.infradead.org&gt;; Linux Kernel Mailing List &lt;linux-kern=
el@vger.kernel.org&gt;; davidgow@google.com &lt;davidgow@google.com&gt;;
 Brendan Higgins &lt;brendanhiggins@google.com&gt;; Anton Ivanov &lt;anton.=
ivanov@cambridgegreys.com&gt;<br>
<b>Subject:</b> Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Wed, Dec 11, 2019 at 9:40 AM Geert Uytterhoeven=
 &lt;geert@linux-m68k.org&gt; wrote:<br>
&gt;<br>
&gt; Hi Brendan,<br>
&gt;<br>
&gt; On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins<br>
&gt; &lt;brendanhiggins@google.com&gt; wrote:<br>
&gt; &gt; Currently, CONFIG_STATIC_LINK can be enabled with options which c=
annot<br>
&gt; &gt; be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and<br>
&gt; &gt; UML_NET_PCAP; this is because glibc tries to load NSS which does =
not<br>
&gt; &gt; support being statically linked. So make CONFIG_STATIC_LINK depen=
d on<br>
&gt; &gt; !UML_NET_VECTOR &amp;&amp; !UML_NET_VDE &amp;&amp; !UML_NET_PCAP.=
<br>
&gt; &gt;<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/lkml/f658f317-be54-ed75-=
8296-c373c2dcc697@cambridgegreys.com/#t">
https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridge=
greys.com/#t</a><br>
&gt; &gt; Signed-off-by: Brendan Higgins &lt;brendanhiggins@google.com&gt;<=
br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; arch/um/Kconfig | 4 &#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/um/Kconfig b/arch/um/Kconfig<br>
&gt; &gt; index 2a6d04fcb3e91..1ddc8745123f2 100644<br>
&gt; &gt; --- a/arch/um/Kconfig<br>
&gt; &gt; &#43;&#43;&#43; b/arch/um/Kconfig<br>
&gt; &gt; @@ -63,6 &#43;63,7 @@ source &quot;arch/$(HEADER_ARCH)/um/Kconfig=
&quot;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; config STATIC_LINK<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Force =
a static link&quot;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !UML_NET_VEC=
TOR &amp;&amp; !UML_NET_VDE &amp;&amp; !UML_NET_PCAP<br>
&gt;<br>
&gt; &quot;depends on !FORBID_STATIC_LINK&quot;?<br>
&gt;<br>
&gt; Then all the drivers that are incompatible with static linking can jus=
t<br>
&gt; select FORBID_STATIC_LINK in their own Kconfig block.<br>
<br>
Makes sense!<br>
<br>
-- <br>
Thanks,<br>
//richard<br>
<br>
_______________________________________________<br>
linux-um mailing list<br>
linux-um@lists.infradead.org<br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-um">http://lis=
ts.infradead.org/mailman/listinfo/linux-um</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN6PR10MB3039E2FB633AC95CF4279B04E2320SN6PR10MB3039namp_--

