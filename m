Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UQk8N-0005rQ-Lv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Apr 2013 19:59:43 +0000
Received: from mail-la0-f49.google.com ([209.85.215.49])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQk8L-0001xz-Rh
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Apr 2013 19:59:43 +0000
Received: by mail-la0-f49.google.com with SMTP id fs12so2850596lab.36
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Apr 2013 12:59:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6CkeTkOWRsYdQyFcutOCYru_nW8Kgp61Yi3w9GZ21VUdX-g@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
	<CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
	<CAER6CkcWS1KUpxBqOh+6N36k8HhQT61OJ+d3N=H3tHygMos39Q@mail.gmail.com>
	<CAFLxGvz8MX6YtAHU6w_hsUX_zDBwBspmUqA_1CjNBO1FxyFyBg@mail.gmail.com>
	<CAER6CkcV+LCLf=iihv_WWuQDJPX1W9ubux4LE3+2yWcHZFUxyA@mail.gmail.com>
	<CAER6CkeTkOWRsYdQyFcutOCYru_nW8Kgp61Yi3w9GZ21VUdX-g@mail.gmail.com>
From: Terry Hsu <terry.shoes@gmail.com>
Date: Fri, 12 Apr 2013 15:58:54 -0400
Message-ID: <CAER6CkcuYOwf2s+n3Gszg4BP55fJQW74KK7W+tQnJiPUpvqSyg@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7367263348279738088=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: richard -rw- weinberger <richard.weinberger@gmail.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============7367263348279738088==
Content-Type: multipart/alternative; boundary=089e01176f039cdc5704da2f5780

--089e01176f039cdc5704da2f5780
Content-Type: text/plain; charset=ISO-8859-1

Do you know which functions are used by UML to write the to be fixed
address into SKAS stub? In the handle_page_fault(), the stub mapping is
never referenced. I print out vm area (in find_vma()) if the address cover
by the stub mapping is referenced, and it prints nothing there.

I want to know when/where the UML writes the to be fixed address into SKAS
stub so I can fix the problem accordingly. I think my UML is using the
wrong SKAS stub to fixed the fault...

Thanks!


On Fri, Apr 12, 2013 at 1:14 AM, Terry Hsu <terry.shoes@gmail.com> wrote:

> okay so I looked into the faultinfo structure and was able to obtain the
> faulting address, error code, and trap number(?). From my understanding the
> error code is the bottom 3 bits of the exception code. But I see error code
> "20" sometimes and do not what it means.
> I am now looking at how the special mapping works with the host kernel. I
> think this might lead me to the solution of my problem. It sounds like the
> special mapping is not installed correctly so that the UML was not able to
> fix the fault.
>
>
>
>
> On Thu, Apr 11, 2013 at 7:00 PM, Terry Hsu <terry.shoes@gmail.com> wrote:
>
>> In the unmodified kernel, I did not see the kernel call mmap (which in
>> turn calls mmap_region) to install the mapping for the faulting page in
>> child task. The child task does not have the UML invoked mmap to install
>> mapping. So I could not examine the parameters passed to mmap neither the
>> return value of it.
>>
>> Thanks for the explanation of the special mapping. After reading your
>> comment I went to Jeff Dike's website to find out more about skas:
>> http://user-mode-linux.sourceforge.net/old/skas.html
>>
>> The handle_pte_fault() calls __do_fault(), which in turn invokes
>> filemap_fault() through
>> vma->vm_ops->fault(vma, &vmf). How do I find out exactly what the miss
>> address is for? I am posting the log I print out here. This is the
>> unmodified kernel version. So the page is faulted in correctly without
>> calling mmap for the forked child task.
>>
>> *Note: this is the correct version of page fault in the unmodified
>> kernel.*
>> [segv_handler] Caller is userspace+0x25d/0x44c, pid 598 a.out
>> [segv] Caller is segv_handler+0xb1/0xbb, pid 598 a.out
>> [handle_page_fault] Caller is segv+0xfa/0x324, pid 598 a.out
>> [handle_page_fault] fault address: 0x400e9cc8
>> [handle_page_fault] page walk for 0x400e9cc8
>> [handle_page_fault] pte does not exist!
>> [handle_page_fault] before handle_page_fault
>> [print_mm_rss_stat] mm->rss_stat for mm id: 673
>> [print_mm_rss_stat] mm->rss_stat.count[0] = 0
>> [print_mm_rss_stat] mm->rss_stat.count[1] = 27
>> [print_mm_rss_stat] mm->rss_stat.count[2] = 0
>> [find_vma] Caller is handle_page_fault+0x1ca/0x957, pid 598 a.out
>> [handle_mm_fault] Caller is handle_page_fault+0x50d/0x957, pid 598 a.out
>> [handle_mm_fault] pgd: 295944192
>> [handle_mm_fault] pud: 295944192
>> [handle_mm_fault] pmd: 294746112
>> [*handle_mm_fault*] pte: 295581512
>> [*handle_pte_fault*] calling do_linear_fault
>> [*__do_fault*] __do_fault for 0x400e9cc8
>> [__do_fault] line 3292 of file mm/memory.c, pid 598
>> [*filemap_fault*] line 1604 of file mm/filemap.c, pid 598
>> [filemap_fault] line 1622 of file mm/filemap.c, pid 598
>> [filemap_fault] line 1654 of file mm/filemap.c, pid 598
>> [filemap_fault] line 1680 of file mm/filemap.c, pid 598
>> [__do_fault] line 3312 of file mm/memory.c, pid 598
>> [__do_fault] line 3367 of file mm/memory.c, pid 598
>> [__do_fault] line 3395 of file mm/memory.c, pid 598
>> [__do_fault] line 3408 of file mm/memory.c, pid 598
>> [__do_fault] line 3425 of file mm/memory.c, pid 598
>> [__do_fault] line 3458 of file mm/memory.c, pid 598
>> [__do_fault] __do_fault for 0x400e9cc8 returning 512
>> [handle_page_fault] line 205 of file arch/um/kernel/trap.c, pid 598
>> [handle_page_fault] mm->mm_id: 673
>> [flush_tlb_page] Caller is handle_page_fault+0x7f5/0x957, pid 598 a.out
>> [flush_tlb_page] mm->mm_id: 673
>> [handle_page_fault] page walk for 0x400e9cc8
>> [handle_page_fault] pte for 0x400e9cc8: 0x119e3748
>> [handle_page_fault] after handle_page_fault
>> [print_mm_rss_stat] mm->rss_stat for mm id: 673
>> [print_mm_rss_stat] mm->rss_stat.count[0] = 1
>> [print_mm_rss_stat] mm->rss_stat.count[1] = 27
>> [print_mm_rss_stat] mm->rss_stat.count[2] = 0
>>
>>
>>
>>
>>
>> On Thu, Apr 11, 2013 at 5:19 PM, richard -rw- weinberger <
>> richard.weinberger@gmail.com> wrote:
>>
>>> On Thu, Apr 11, 2013 at 10:14 PM, Terry Hsu <terry.shoes@gmail.com>
>>> wrote:
>>> > The page fault loop for the same address happens in my UML. But for
>>> both my
>>> > UML and the mainline (I am using 3.7.1) kernel, the addresses that
>>> trigger
>>> > the page fault (in the child thread) are covered by certain vm areas.
>>> I use
>>> > gdb to trace the function call and notice that mmap_region() is never
>>> called
>>> > during the execution of the child task. I am guessing it's because the
>>> child
>>> > task does not use large enough memory space to have the UML installed
>>> > mapping for it.
>>>
>>> Okay, let's try to figure out what happens here.
>>> The UML _guest_ process has some vmas installed, upon access the host
>>> kernel finds
>>> out that there is no memory mapping installed in the _host_ side of
>>> UML and sends SIGSEGV
>>> to the process. UML's host part catches the SIGSEGV and tries to fix it.
>>> Usually it does so by mmap()'ing the faulting page into the UML guest
>>> process.
>>> This is where the SKAS stub magic happens. It write the to be fixed
>>> address into STUB_DATA
>>> and sets EIP/RIP to STUB_CODE such that the process itself calls mmap().
>>> After the stub has finished it traps itself and the UML emulation
>>> continues.
>>>
>>> Now we need to figure out a) What address is faulting and why? b) What
>>> does the UML _host_ side
>>> code to fix it? i.e. What are the mmap() parameters? c) Does this mmap()
>>> fail?
>>>
>>> To me it looks like UML is unable to fix the fault and therefore it
>>> faults over and over again.
>>>
>>> --
>>> Thanks,
>>> //richard
>>>
>>
>>
>

--089e01176f039cdc5704da2f5780
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Do you know which functions are used by UML to write the t=
o be fixed address into SKAS stub? In the handle_page_fault(), the stub map=
ping is never referenced. I print out vm area (in find_vma()) if the addres=
s cover by the stub mapping is referenced, and it prints nothing there.<div=
>

<br></div><div>I want to know when/where the UML writes the to be fixed add=
ress into SKAS stub so I can fix the problem accordingly. I think my UML is=
 using the wrong SKAS stub to fixed the fault...<div><br></div><div style>

Thanks! =A0</div></div></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Fri, Apr 12, 2013 at 1:14 AM, Terry Hsu <span dir=3D"lt=
r">&lt;<a href=3D"mailto:terry.shoes@gmail.com" target=3D"_blank">terry.sho=
es@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">okay so I looked into the f=
aultinfo structure and was able to obtain the faulting address, error code,=
 and trap number(?). From my understanding the error code is the bottom 3 b=
its of the exception code. But I see error code &quot;20&quot; sometimes an=
d do not what it means.=A0<div>




I am now looking at how the special mapping works with the host kernel. I t=
hink this might lead me to the solution of my problem. It sounds like the s=
pecial mapping is not installed correctly so that the UML was not able to f=
ix the fault.<div>




<br></div><div><br></div></div><div><div class=3D"h5"><div class=3D"gmail_e=
xtra"><br><br><div class=3D"gmail_quote">On Thu, Apr 11, 2013 at 7:00 PM, T=
erry Hsu <span dir=3D"ltr">&lt;<a href=3D"mailto:terry.shoes@gmail.com" tar=
get=3D"_blank">terry.shoes@gmail.com</a>&gt;</span> wrote:<br>




<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">In the unmodified kernel, I=
 did not see the kernel call mmap (which in turn calls mmap_region) to inst=
all the mapping for the faulting page in child task. The child task does no=
t have the UML invoked mmap to install mapping.=A0So I could not examine th=
e parameters passed to mmap neither the return value of it.<div>







<br></div><div>Thanks for the explanation of the special mapping. After rea=
ding your comment I went to Jeff Dike&#39;s website to find out more about =
skas:=A0<a href=3D"http://user-mode-linux.sourceforge.net/old/skas.html" ta=
rget=3D"_blank">http://user-mode-linux.sourceforge.net/old/skas.html</a></d=
iv>







<div><br></div><div>The handle_pte_fault() calls __do_fault(), which in tur=
n invokes filemap_fault() through=A0<br>vma-&gt;vm_ops-&gt;fault(vma, &amp;=
vmf). How do I find out exactly what the miss address is for? I am posting =
the log I print out here. This is the unmodified kernel version. So the pag=
e is faulted in correctly without calling mmap for the forked child task.</=
div>






<div><font face=3D"courier new, monospace"><br></font></div><div><font face=
=3D"courier new, monospace"><b>Note: this is the correct version of page fa=
ult in the unmodified kernel.</b></font></div><div><div><font face=3D"couri=
er new, monospace">[segv_handler] Caller is userspace+0x25d/0x44c, pid 598 =
a.out</font></div>






<div><font face=3D"courier new, monospace">[segv] Caller is segv_handler+0x=
b1/0xbb, pid 598 a.out</font></div><div><font face=3D"courier new, monospac=
e">[handle_page_fault] Caller is segv+0xfa/0x324, pid 598 a.out</font></div=
>






<div><font face=3D"courier new, monospace">[handle_page_fault] fault addres=
s: 0x400e9cc8</font></div><div><font face=3D"courier new, monospace">[handl=
e_page_fault] page walk for 0x400e9cc8</font></div><div><font face=3D"couri=
er new, monospace">[handle_page_fault] pte does not exist!</font></div>






<div><font face=3D"courier new, monospace">[handle_page_fault] before handl=
e_page_fault</font></div><div><font face=3D"courier new, monospace">[print_=
mm_rss_stat] mm-&gt;rss_stat for mm id: 673</font></div><div><font face=3D"=
courier new, monospace">[print_mm_rss_stat] mm-&gt;rss_stat.count[0] =3D 0=
=A0</font></div>






<div><font face=3D"courier new, monospace">[print_mm_rss_stat] mm-&gt;rss_s=
tat.count[1] =3D 27=A0</font></div><div><font face=3D"courier new, monospac=
e">[print_mm_rss_stat] mm-&gt;rss_stat.count[2] =3D 0=A0</font></div><div><=
font face=3D"courier new, monospace">[find_vma] Caller is handle_page_fault=
+0x1ca/0x957, pid 598 a.out</font></div>






<div><font face=3D"courier new, monospace">[handle_mm_fault] Caller is hand=
le_page_fault+0x50d/0x957, pid 598 a.out</font></div><div><font face=3D"cou=
rier new, monospace">[handle_mm_fault] pgd: 295944192</font></div><div><fon=
t face=3D"courier new, monospace">[handle_mm_fault] pud: 295944192</font></=
div>






<div><font face=3D"courier new, monospace">[handle_mm_fault] pmd: 294746112=
</font></div><div><font face=3D"courier new, monospace">[<b>handle_mm_fault=
</b>] pte: 295581512</font></div><div><font face=3D"courier new, monospace"=
>[<b>handle_pte_fault</b>] calling do_linear_fault</font></div>






<div><font face=3D"courier new, monospace">[<b>__do_fault</b>] __do_fault f=
or 0x400e9cc8</font></div><div><font face=3D"courier new, monospace">[__do_=
fault] line 3292 of file mm/memory.c, pid 598</font></div><div><font face=
=3D"courier new, monospace">[<b>filemap_fault</b>] line 1604 of file mm/fil=
emap.c, pid 598</font></div>






<div><font face=3D"courier new, monospace">[filemap_fault] line 1622 of fil=
e mm/filemap.c, pid 598</font></div><div><font face=3D"courier new, monospa=
ce">[filemap_fault] line 1654 of file mm/filemap.c, pid 598</font></div><di=
v>






<font face=3D"courier new, monospace">[filemap_fault] line 1680 of file mm/=
filemap.c, pid 598</font></div><div><font face=3D"courier new, monospace">[=
__do_fault] line 3312 of file mm/memory.c, pid 598</font></div><div><font f=
ace=3D"courier new, monospace">[__do_fault] line 3367 of file mm/memory.c, =
pid 598</font></div>






<div><font face=3D"courier new, monospace">[__do_fault] line 3395 of file m=
m/memory.c, pid 598</font></div><div><font face=3D"courier new, monospace">=
[__do_fault] line 3408 of file mm/memory.c, pid 598</font></div><div><font =
face=3D"courier new, monospace">[__do_fault] line 3425 of file mm/memory.c,=
 pid 598</font></div>






<div><font face=3D"courier new, monospace">[__do_fault] line 3458 of file m=
m/memory.c, pid 598</font></div><div><font face=3D"courier new, monospace">=
[__do_fault] __do_fault for 0x400e9cc8 returning 512</font></div><div><font=
 face=3D"courier new, monospace">[handle_page_fault] line 205 of file arch/=
um/kernel/trap.c, pid 598</font></div>






<div><font face=3D"courier new, monospace">[handle_page_fault] mm-&gt;mm_id=
: 673</font></div><div><font face=3D"courier new, monospace">[flush_tlb_pag=
e] Caller is handle_page_fault+0x7f5/0x957, pid 598 a.out</font></div><div>






<font face=3D"courier new, monospace">[flush_tlb_page] mm-&gt;mm_id: 673</f=
ont></div><div><font face=3D"courier new, monospace">[handle_page_fault] pa=
ge walk for 0x400e9cc8</font></div><div><font face=3D"courier new, monospac=
e">[handle_page_fault] pte for 0x400e9cc8: 0x119e3748</font></div>






<div><font face=3D"courier new, monospace">[handle_page_fault] after handle=
_page_fault</font></div><div><font face=3D"courier new, monospace">[print_m=
m_rss_stat] mm-&gt;rss_stat for mm id: 673</font></div><div><font face=3D"c=
ourier new, monospace">[print_mm_rss_stat] mm-&gt;rss_stat.count[0] =3D 1=
=A0</font></div>






<div><font face=3D"courier new, monospace">[print_mm_rss_stat] mm-&gt;rss_s=
tat.count[1] =3D 27=A0</font></div><div><font face=3D"courier new, monospac=
e">[print_mm_rss_stat] mm-&gt;rss_stat.count[2] =3D 0=A0</font></div></div>=
<div><div>




<div><font face=3D"courier new, monospace"><br>

</font></div><div><br></div><div>
<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Thu, Apr 11, 2013 at 5:19 PM, richard -rw- weinberger <span dir=3D"ltr">&lt=
;<a href=3D"mailto:richard.weinberger@gmail.com" target=3D"_blank">richard.=
weinberger@gmail.com</a>&gt;</span> wrote:<br>






<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Thu, Apr 11, 2013 at 10:14 PM, Terry=
 Hsu &lt;<a href=3D"mailto:terry.shoes@gmail.com" target=3D"_blank">terry.s=
hoes@gmail.com</a>&gt; wrote:<br>







&gt; The page fault loop for the same address happens in my UML. But for bo=
th my<br>
&gt; UML and the mainline (I am using 3.7.1) kernel, the addresses that tri=
gger<br>
&gt; the page fault (in the child thread) are covered by certain vm areas. =
I use<br>
&gt; gdb to trace the function call and notice that mmap_region() is never =
called<br>
&gt; during the execution of the child task. I am guessing it&#39;s because=
 the child<br>
&gt; task does not use large enough memory space to have the UML installed<=
br>
&gt; mapping for it.<br>
<br>
</div>Okay, let&#39;s try to figure out what happens here.<br>
The UML _guest_ process has some vmas installed, upon access the host<br>
kernel finds<br>
out that there is no memory mapping installed in the _host_ side of<br>
UML and sends SIGSEGV<br>
to the process. UML&#39;s host part catches the SIGSEGV and tries to fix it=
.<br>
Usually it does so by mmap()&#39;ing the faulting page into the UML guest p=
rocess.<br>
This is where the SKAS stub magic happens. It write the to be fixed<br>
address into STUB_DATA<br>
and sets EIP/RIP to STUB_CODE such that the process itself calls mmap().<br=
>
After the stub has finished it traps itself and the UML emulation continues=
.<br>
<br>
Now we need to figure out a) What address is faulting and why? b) What<br>
does the UML _host_ side<br>
code to fix it? i.e. What are the mmap() parameters? c) Does this mmap() fa=
il?<br>
<br>
To me it looks like UML is unable to fix the fault and therefore it<br>
faults over and over again.<br>
<br>
--<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div></div></div></div>
</blockquote></div><br></div></div></div></div>
</blockquote></div><br></div>

--089e01176f039cdc5704da2f5780--


--===============7367263348279738088==
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
--===============7367263348279738088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7367263348279738088==--


