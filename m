Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UQNtf-0007xr-8K
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 20:15:03 +0000
Received: from mail-la0-f52.google.com ([209.85.215.52])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQNte-0001u9-8M
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 20:15:03 +0000
Received: by mail-la0-f52.google.com with SMTP id ek20so504231lab.25
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Apr 2013 13:14:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
	<CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
From: Terry Hsu <terry.shoes@gmail.com>
Date: Thu, 11 Apr 2013 16:14:14 -0400
Message-ID: <CAER6CkcWS1KUpxBqOh+6N36k8HhQT61OJ+d3N=H3tHygMos39Q@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5046119721398325348=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============5046119721398325348==
Content-Type: multipart/alternative; boundary=089e01176f03a289ca04da1b7050

--089e01176f03a289ca04da1b7050
Content-Type: text/plain; charset=ISO-8859-1

The page fault loop for the same address happens in my UML. But for both my
UML and the mainline (I am using 3.7.1) kernel, the addresses that trigger
the page fault (in the child thread) are covered by certain vm areas. I use
gdb to trace the function call and notice that mmap_region() is never
called during the execution of the child task. I am guessing it's because
the child task does not use large enough memory space to have the UML
installed mapping for it.

The major change I did to my kernel is to modify the vm areas pointers of
certain child tasks to share the vm area structure of its parent task. So
the parent task's vm areas are shared (as long as VM_DONTCOPY is not set)
among some of its child tasks.


On Thu, Apr 11, 2013 at 9:04 AM, richard -rw- weinberger <
richard.weinberger@gmail.com> wrote:

> On Thu, Apr 11, 2013 at 6:15 AM, Terry Hsu <terry.shoes@gmail.com> wrote:
> > Hi Richard, thanks for replying. I did go back to see the code and try to
> > understand what exactly is going on in UML, but still no luck.
> >
> > The faulted address is covered by one of the vm areas of the task, so it
> > passed the vma sanity check at the beginning of handle_page_fault(). I
> print
> > out the PTEs of the task and I notice one strange thing: when the fault
> > happens for the first time, the PTE does not exist; the PTE is present
> when
> > the second fault happens for the same address (but still a page fault);
> in
> > the third page fault (same address), the PTE does not exist anymore.
> >
> > So in my case, the faulted address does not require a new vma to be
> > installed.
>
> But this is a feature added by you?
> We are not talking about a mainline kernel, right?


> > Also I've looked into copy_mm() to see how pages are copied from parent
> task
> > to its child. I do not understand the purpose of the  the special mapping
> > installed by UML. It seems that every new task with a new mm_struct will
> > have one special mapping at the head of its vma list.
>
> The special mapping (the SKAS stub) is needed to install new mapping
> from the host
> side of UML.
> Currently the stub pages have a vma, this will go away such that they
> have only a PTE.
>
> --
> Thanks,
> //richard
>

--089e01176f03a289ca04da1b7050
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The page fault loop for the same address happens in my UML=
. But for both my UML and the mainline (I am using 3.7.1) kernel, the addre=
sses that trigger the page fault (in the child thread) are covered by certa=
in vm areas. I use gdb to trace the function call and notice that=A0mmap_re=
gion() is never called during the execution of the child task. I am guessin=
g it&#39;s because the child task does not use large enough memory space to=
 have the UML installed mapping for it.<div>



<br></div><div>The major change I did to my kernel is to modify the vm area=
s pointers of certain child tasks to share the vm area structure of its par=
ent task. So the parent task&#39;s vm areas are shared (as long as VM_DONTC=
OPY is not set) among some of its child tasks.<br>




<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Apr 1=
1, 2013 at 9:04 AM, richard -rw- weinberger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:richard.weinberger@gmail.com" target=3D"_blank">richard.weinberg=
er@gmail.com</a>&gt;</span> wrote:<br>




<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div>On Thu, Apr 11, 2013 at 6:15 AM, Terry Hsu &lt;<a hre=
f=3D"mailto:terry.shoes@gmail.com" target=3D"_blank">terry.shoes@gmail.com<=
/a>&gt; wrote:<br>





&gt; Hi Richard, thanks for replying. I did go back to see the code and try=
 to<br>
&gt; understand what exactly is going on in UML, but still no luck.<br>
&gt;<br>
&gt; The faulted address is covered by one of the vm areas of the task, so =
it<br>
&gt; passed the vma sanity check at the beginning of handle_page_fault(). I=
 print<br>
&gt; out the PTEs of the task and I notice one strange thing: when the faul=
t<br>
&gt; happens for the first time, the PTE does not exist; the PTE is present=
 when<br>
&gt; the second fault happens for the same address (but still a page fault)=
; in<br>
&gt; the third page fault (same address), the PTE does not exist anymore.<b=
r>
&gt;<br>
&gt; So in my case, the faulted address does not require a new vma to be<br=
>
&gt; installed.<br>
<br>
</div>But this is a feature added by you?<br>
We are not talking about a mainline kernel, right?=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex">




<div><br>
&gt; Also I&#39;ve looked into copy_mm() to see how pages are copied from p=
arent task<br>
&gt; to its child. I do not understand the purpose of the =A0the special ma=
pping<br>
&gt; installed by UML. It seems that every new task with a new mm_struct wi=
ll<br>
&gt; have one special mapping at the head of its vma list.<br>
<br>
</div>The special mapping (the SKAS stub) is needed to install new mapping<=
br>
from the host<br>
side of UML.<br>
Currently the stub pages have a vma, this will go away such that they<br>
have only a PTE.<br>
<br>
--<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div></div></div>

--089e01176f03a289ca04da1b7050--


--===============5046119721398325348==
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
--===============5046119721398325348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5046119721398325348==--


