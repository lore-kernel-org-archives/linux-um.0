Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UQwfj-0004pL-Ke
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Apr 2013 09:22:59 +0000
Received: from mail-wi0-f174.google.com ([209.85.212.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQwfi-0004Ry-RJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Apr 2013 09:22:59 +0000
Received: by mail-wi0-f174.google.com with SMTP id hj8so257315wib.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Apr 2013 02:22:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6CkcjCj7HR7X-P4FPGzFkY=2ak9U41a-_mMwR9TwucwuoQg@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
	<CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
	<CAER6CkcWS1KUpxBqOh+6N36k8HhQT61OJ+d3N=H3tHygMos39Q@mail.gmail.com>
	<CAFLxGvz8MX6YtAHU6w_hsUX_zDBwBspmUqA_1CjNBO1FxyFyBg@mail.gmail.com>
	<CAER6CkcV+LCLf=iihv_WWuQDJPX1W9ubux4LE3+2yWcHZFUxyA@mail.gmail.com>
	<CAER6CkeTkOWRsYdQyFcutOCYru_nW8Kgp61Yi3w9GZ21VUdX-g@mail.gmail.com>
	<CAER6CkcjCj7HR7X-P4FPGzFkY=2ak9U41a-_mMwR9TwucwuoQg@mail.gmail.com>
Date: Sat, 13 Apr 2013 11:22:52 +0200
Message-ID: <CAFLxGvzidxYXkzo9B16i3CfY42KLeHuYqho3umvh0Nogq_RwHg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: Terry Hsu <terry.shoes@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Apr 13, 2013 at 4:59 AM, Terry Hsu <terry.shoes@gmail.com> wrote:
>
> On Fri, Apr 12, 2013 at 1:14 AM, Terry Hsu <terry.shoes@gmail.com> wrote:
>>
>> okay so I looked into the faultinfo structure and was able to obtain the
>> faulting address, error code, and trap number(?). From my understanding =
the
>> error code is the bottom 3 bits of the exception code. But I see error c=
ode
>> "20" sometimes and do not what it means.
>
>
> According to p.6-55 in Intel=AE 64 and IA-32 Architectures Software
> Developer=92s Manual, Volume 3: System Programming Guide, the lower 5 bit=
s are
> Present, Read/Write, User/supervisor, RSVD, and Instruction/Data bit
> respectively. So error code 20 means the fault is caused by an instruction
> read to a non-present page in user mode.
>
> I found the the reason why the fault cannot be fixed by UML. It is probab=
ly
> because UML puts the faultinfo in the wrong stub, since I changed the vm
> area pointers of the child process, when the fault happens, UML incorrect=
ly
> finds its parent process's stub pages and puts the faultinfo in it.
> Therefore when the child process tries to access its own skas stub and fix
> the fault, it still cannot find the correct instruction pointers hence the
> fault happens endlessly.

Can you share an example with us which triggers the issue?

> Why does every process that runs in UML need its own stub for page fault
> handling? It seems to me they could've shared the SIGSEGV signal handler =
and
> the function that invokes mmap, munmap, mprotect. In this way only two pa=
ges
> are needed for all the processes.
>
> I am not sure if I understand the whole thing correctly. Please correct me
> if it's not right.

We need a stub per process because the installs a mapping into the
prozess (on the host size).
As mmap() always operates on current, we need a way to make the
prozess call mmap() itself.
The stub does this.

--
Thanks,
//richard

---------------------------------------------------------------------------=
---
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

