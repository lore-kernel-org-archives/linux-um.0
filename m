Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UQ8w7-0003HU-25
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 04:16:35 +0000
Received: from mail-qe0-f47.google.com ([209.85.128.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQ8w6-0007uR-46
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 04:16:34 +0000
Received: by mail-qe0-f47.google.com with SMTP id w7so677109qeb.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Apr 2013 21:16:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
From: Terry Hsu <terry.shoes@gmail.com>
Date: Thu, 11 Apr 2013 00:15:48 -0400
Message-ID: <CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5876949475181487115=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============5876949475181487115==
Content-Type: multipart/alternative; boundary=047d7bdc0c4ef512c104da0e0ccd

--047d7bdc0c4ef512c104da0e0ccd
Content-Type: text/plain; charset=ISO-8859-1

Hi Richard, thanks for replying. I did go back to see the code and try to
understand what exactly is going on in UML, but still no luck.

The faulted address is covered by one of the vm areas of the task, so it
passed the vma sanity check at the beginning of handle_page_fault(). I
print out the PTEs of the task and I notice one strange thing: when the
fault happens for the first time, the PTE does not exist; the PTE is
present when the second fault happens for the same address (but still a
page fault); in the third page fault (same address), the PTE does not exist
anymore.

So in my case, the faulted address does not require a new vma to be
installed.

Also I've looked into copy_mm() to see how pages are copied from parent
task to its child. I do not understand the purpose of the  the special
mapping installed by UML. It seems that every new task with a new mm_struct
will have one special mapping at the head of its vma list.

Thanks.


On Sun, Apr 7, 2013 at 12:52 PM, richard -rw- weinberger <
richard.weinberger@gmail.com> wrote:

> On Sat, Apr 6, 2013 at 9:23 PM, Terry Hsu <terry.shoes@gmail.com> wrote:
> > Is there any available resource that explains how user-mode-linux maps
> the
> > pages of a task in UML to the host kernel?
>
> The code...? ;)
> UML receives a SIGEGV on the host side if a page is not mapped.
> The SIGEGV handler then installs the mapping using mmap().
>
> > In my UML, I modified a task's page table when forking it. Then I ran
> into a
> > situation where the page fault happens over and over again for the same
> > address in the forked task. I use gdb debugger and find out that when the
> > page fault happens for the first time, the kernel calls do_wp_page() to
> > fault in the page and marks the page present. This should prevent the
> next
> > page fault for the same address from happening again. I checked the PTE
> in
> > UML, they are marked as present so is it possible that the page is not
> being
> > allocated properly on the host kernel so that the page fault keeps
> happening
> > for the same address even though UML thinks the page is present.
> >
> > Any suggestions?
>
> If the same fault happens over and over UML (on the host side) seems
> unable to fix the fault.
> Check the return values of mmap()....
>
> Thanks,
> //richard
>

--047d7bdc0c4ef512c104da0e0ccd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard, thanks for replying. I did go back to see=
 the code and try to understand what exactly is going on in UML, but still =
no luck.</div><div><br></div><div>The faulted address is covered by one of =
the vm areas of the task, so it passed the vma sanity check at the beginnin=
g of handle_page_fault(). I print out the PTEs of the task and I notice one=
 strange thing: when the fault happens for the first time, the PTE does not=
 exist; the PTE is present when the second fault happens for the same addre=
ss (but still a page fault); in the third page fault (same address), the PT=
E does not exist anymore.=A0</div>

<div><br></div><div style>So in my case, the faulted address does not requi=
re a new vma to be installed.</div>
<div><br></div>Also I&#39;ve looked into copy_mm() to see how pages are cop=
ied from parent task to its child. I do not understand the purpose of the =
=A0the special mapping installed by UML. It seems that every new task with =
a new mm_struct will have one special mapping at the head of its vma list.=
=A0<div>

<br></div><div style>Thanks.</div></div><div class=3D"gmail_extra"><br><br>=
<div class=3D"gmail_quote">On Sun, Apr 7, 2013 at 12:52 PM, richard -rw- we=
inberger <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.weinberger@gmail.c=
om" target=3D"_blank">richard.weinberger@gmail.com</a>&gt;</span> wrote:<br=
>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Sat, Apr 6, 2013 at 9:2=
3 PM, Terry Hsu &lt;<a href=3D"mailto:terry.shoes@gmail.com">terry.shoes@gm=
ail.com</a>&gt; wrote:<br>


&gt; Is there any available resource that explains how user-mode-linux maps=
 the<br>
&gt; pages of a task in UML to the host kernel?<br>
<br>
</div>The code...? ;)<br>
UML receives a SIGEGV on the host side if a page is not mapped.<br>
The SIGEGV handler then installs the mapping using mmap().<br>
<div class=3D"im"><br>
&gt; In my UML, I modified a task&#39;s page table when forking it. Then I =
ran into a<br>
&gt; situation where the page fault happens over and over again for the sam=
e<br>
&gt; address in the forked task. I use gdb debugger and find out that when =
the<br>
&gt; page fault happens for the first time, the kernel calls do_wp_page() t=
o<br>
&gt; fault in the page and marks the page present. This should prevent the =
next<br>
&gt; page fault for the same address from happening again. I checked the PT=
E in<br>
&gt; UML, they are marked as present so is it possible that the page is not=
 being<br>
&gt; allocated properly on the host kernel so that the page fault keeps hap=
pening<br>
&gt; for the same address even though UML thinks the page is present.<br>
&gt;<br>
&gt; Any suggestions?<br>
<br>
</div>If the same fault happens over and over UML (on the host side) seems<=
br>
unable to fix the fault.<br>
Check the return values of mmap()....<br>
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div>

--047d7bdc0c4ef512c104da0e0ccd--


--===============5876949475181487115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
--===============5876949475181487115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5876949475181487115==--


