Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UQqhP-0006wy-1h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Apr 2013 03:00:19 +0000
Received: from mail-la0-f42.google.com ([209.85.215.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQqhN-0001JX-CE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Apr 2013 03:00:19 +0000
Received: by mail-la0-f42.google.com with SMTP id fn20so2752299lab.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Apr 2013 20:00:10 -0700 (PDT)
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
Date: Fri, 12 Apr 2013 22:59:30 -0400
Message-ID: <CAER6CkcjCj7HR7X-P4FPGzFkY=2ak9U41a-_mMwR9TwucwuoQg@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5891161763293066069=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: richard -rw- weinberger <richard.weinberger@gmail.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============5891161763293066069==
Content-Type: multipart/alternative; boundary=f46d040714d5c3753f04da3537af

--f46d040714d5c3753f04da3537af
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 1:14 AM, Terry Hsu <terry.shoes@gmail.com> wrote:

> okay so I looked into the faultinfo structure and was able to obtain the
> faulting address, error code, and trap number(?). From my understanding t=
he
> error code is the bottom 3 bits of the exception code. But I see error co=
de
> "20" sometimes and do not what it means.
>

According to p.6-55 in Intel=AE 64 and IA-32 Architectures Software
Developer=92s Manual, Volume 3: System Programming
Guide<http://download.intel.com/design/processor/manuals/253668.pdf>,
the lower 5 bits are Present, Read/Write, User/supervisor, RSVD, and
Instruction/Data bit respectively. So error code 20 means the fault is
caused by an instruction read to a non-present page in user mode.

I found the the reason why the fault cannot be fixed by UML. It is probably
because UML puts the faultinfo in the wrong stub, since I changed the vm
area pointers of the child process, when the fault happens, UML incorrectly
finds its parent process's stub pages and puts the faultinfo in it.
Therefore when the child process tries to access its own skas stub and fix
the fault, it still cannot find the correct instruction pointers hence the
fault happens endlessly.

Why does every process that runs in UML need its own stub for page fault
handling? It seems to me they could've shared the SIGSEGV signal handler
and the function that invokes mmap, munmap, mprotect. In this way only two
pages are needed for all the processes.

I am not sure if I understand the whole thing correctly. Please correct me
if it's not right.

Thanks!

 I am now looking at how the special mapping works with the host kernel. I
> think this might lead me to the solution of my problem. It sounds like th=
e
> special mapping is not installed correctly so that the UML was not able t=
o
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
>> mapping. So I could not examine the parameters passed to mmap neither th=
e
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
>> [print_mm_rss_stat] mm->rss_stat.count[0] =3D 0
>> [print_mm_rss_stat] mm->rss_stat.count[1] =3D 27
>> [print_mm_rss_stat] mm->rss_stat.count[2] =3D 0
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
>> [print_mm_rss_stat] mm->rss_stat.count[0] =3D 1
>> [print_mm_rss_stat] mm->rss_stat.count[1] =3D 27
>> [print_mm_rss_stat] mm->rss_stat.count[2] =3D 0
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
>>> > during the execution of the child task. I am guessing it's because th=
e
>>> child
>>> > task does not use large enough memory space to have the UML installed
>>> > mapping for it.
>>>
>>> Okay, let's try to figure out what happens here.
>>> The UML _guest_ process has some vmas installed, upon access the host
>>> kernel finds
>>> out that there is no memory mapping installed in the _host_ side of
>>> UML and sends SIGSEGV
>>> to the process. UML's host part catches the SIGSEGV and tries to fix it=
.
>>> Usually it does so by mmap()'ing the faulting page into the UML guest
>>> process.
>>> This is where the SKAS stub magic happens. It write the to be fixed
>>> address into STUB_DATA
>>> and sets EIP/RIP to STUB_CODE such that the process itself calls mmap()=
.
>>> After the stub has finished it traps itself and the UML emulation
>>> continues.
>>>
>>> Now we need to figure out a) What address is faulting and why? b) What
>>> does the UML _host_ side
>>> code to fix it? i.e. What are the mmap() parameters? c) Does this mmap(=
)
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

--f46d040714d5c3753f04da3537af
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Fri, Apr 12, 2013 at 1:14 AM, Terry Hsu <span dir=3D"ltr">&lt;<a href=3D=
"mailto:terry.shoes@gmail.com" target=3D"_blank">terry.shoes@gmail.com</a>&=
gt;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr">okay so I looked into the faultinfo struc=
ture and was able to obtain the faulting address, error code, and trap numb=
er(?). From my understanding the error code is the bottom 3 bits of the exc=
eption code. But I see error code &quot;20&quot; sometimes and do not what =
it means.=A0</div>



</blockquote><div><br></div><div>According to p.6-55 in <a href=3D"http://d=
ownload.intel.com/design/processor/manuals/253668.pdf" target=3D"_blank">In=
tel=AE 64 and IA-32 Architectures Software Developer=92s Manual, Volume 3: =
System Programming Guide</a>, the lower 5 bits are Present, Read/Write, Use=
r/supervisor, RSVD, and Instruction/Data bit respectively. So error code 20=
 means the fault is caused by an instruction read to a non-present page in =
user mode.=A0</div>



<div><br></div><div>I found the the reason why the fault cannot be fixed by=
 UML. It is probably because UML puts the faultinfo in the wrong stub, sinc=
e I changed the vm area pointers of the child process, when the fault happe=
ns, UML incorrectly finds its parent process&#39;s stub pages and puts the =
faultinfo in it. Therefore when the child process tries to access its own s=
kas stub and fix the fault, it still cannot find the correct instruction po=
inters hence the fault happens endlessly.</div>



<div style><br></div><div style>Why does every process that runs in UML nee=
d its own stub for page fault handling? It seems to me they could&#39;ve sh=
ared the SIGSEGV signal handler and the function that invokes mmap, munmap,=
 mprotect. In this way only two pages are needed for all the processes.</di=
v>

<div style><br></div><div>I am not sure if I understand the whole thing cor=
rectly. Please correct me if it&#39;s not right.=A0</div><div><br></div><di=
v>Thanks!</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">



<div dir=3D"ltr"><div>


I am now looking at how the special mapping works with the host kernel. I t=
hink this might lead me to the solution of my problem. It sounds like the s=
pecial mapping is not installed correctly so that the UML was not able to f=
ix the fault.<div>






<br></div><div><br></div></div><div><div><div class=3D"gmail_extra"><br><br=
><div class=3D"gmail_quote">On Thu, Apr 11, 2013 at 7:00 PM, Terry Hsu <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:terry.shoes@gmail.com" target=3D"_blank=
">terry.shoes@gmail.com</a>&gt;</span> wrote:<br>






<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr">In the unmodified kernel, I did not see t=
he kernel call mmap (which in turn calls mmap_region) to install the mappin=
g for the faulting page in child task. The child task does not have the UML=
 invoked mmap to install mapping.=A0So I could not examine the parameters p=
assed to mmap neither the return value of it.<div>









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








<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div>On Thu, Apr 11, 2013 at 10:14 PM, Terry Hsu &lt;<a hr=
ef=3D"mailto:terry.shoes@gmail.com" target=3D"_blank">terry.shoes@gmail.com=
</a>&gt; wrote:<br>









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
</blockquote></div><br></div></div>

--f46d040714d5c3753f04da3537af--


--===============5891161763293066069==
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
--===============5891161763293066069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5891161763293066069==--


