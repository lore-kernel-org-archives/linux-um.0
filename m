Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR1Oo-0007k4-LC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 02:03:10 -0700
Received: from dns1.exasol.com ([62.146.138.134])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KR1Ol-0007Op-H8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 02:03:10 -0700
Received: from dns1.exasol.com (root@localhost)
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m7792wSX016470 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 7 Aug 2008 11:02:58 +0200
Received: from mail2 (fwgw.exasol.com [62.146.138.137])
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m7792vYX016462 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 7 Aug 2008 11:02:58 +0200
Message-ID: <489ABA3C.5010903@exasol.com>
Date: Thu, 07 Aug 2008 11:02:52 +0200
From: juergen.kadidlo@exasol.com
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com>
	<48988612.3030204@panasas.com> <489979BD.7060103@exasol.com>
	<48998FBD.6080705@panasas.com>
	<48999834.1000707@exasol.com> <4899C293.7070501@panasas.com>
In-Reply-To: <4899C293.7070501@panasas.com>
Subject: Re: [uml-devel] kernel module support broken on x86-64?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0504124794=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0504124794==
Content-Type: multipart/alternative;
	boundary="------------080002030609000609080001"

This is a multi-part message in MIME format.
--------------080002030609000609080001
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Boaz Harrosh schrieb:
> juergen.kadidlo@exasol.com wrote:
> <snip>
>   
>> except for the 2.6.26 which still exits with a panic on startup...
>>
>>     
>
> BTW: v2.6.26 checkout from Linus git crashes for me too
> 2.6.27-rc1 is fine (except it has another problem which I'm bisecting now)
>
> here is the BUG_ON trace:
> Stub registers -
>         0 - 0
>         1 - 0
>         2 - 0
>         3 - 0
>         4 - 0
>         5 - 0
>         6 - 0
>         7 - 0
>         8 - 0
>         9 - 0
>         10 - 0
>         11 - 0
>         12 - 0
>         13 - 0
>         14 - 0
>         15 - ffffffffffffffff
>         16 - 0
>         17 - 33
>         18 - 10216
>         19 - 2aaaaaab0f30
>         20 - 2b
>         21 - 2aaaaaaad910
>         22 - 0
>         23 - 0
>         24 - 0
>         25 - 0
>         26 - 0
> wait_stub_done : failed to wait for SIGTRAP, pid = 1348, n = 1348, errno = 0, status = 0xb7f
> Kernel panic - not syncing: Attempted to kill init!
>
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.26
> RIP: 0033:[<000000319e430a57>]
> RSP: 00007fff26d69cd8  EFLAGS: 00000206
> RAX: 0000000000000000 RBX: 000000000000053e RCX: ffffffffffffffff
> RDX: 0000000000000000 RSI: 0000000000000013 RDI: 000000000000053e
> RBP: 00007fff26d69d00 R08: 0000000000000000 R09: 00007fff26d69d00
> R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000053a
> R13: 0000000000000004 R14: 00007fff26d6b58c R15: 00007fff26d69fc0
> Call Trace:
> 6fc21778:  [<60013bc1>] panic_exit+0x2f/0x45
> 6fc21798:  [<600412f5>] notifier_call_chain+0x33/0x5b
> 6fc217d8:  [<60041326>] __atomic_notifier_call_chain+0x9/0xb
> 6fc217e8:  [<60041337>] atomic_notifier_call_chain+0xf/0x11
> 6fc217f8:  [<6002b8a1>] panic+0xe6/0x17d
> 6fc21818:  [<60053abe>] get_page_from_freelist+0x2a1/0x41f
> 6fc218b8:  [<6006a144>] kmem_cache_free+0x55/0x5e
> 6fc218e8:  [<6002eca3>] do_exit+0x6b/0x694
> 6fc21908:  [<60036bcd>] __dequeue_signal+0x10e/0x172
> 6fc21958:  [<6002f35c>] do_group_exit+0x90/0xbf
> 6fc21998:  [<60037c30>] get_signal_to_deliver+0x2ca/0x318
> 6fc219b8:  [<60026b7f>] wake_up_state+0xb/0xd
> 6fc219f8:  [<6001202d>] do_signal+0x1f8/0x2ca
> 6fc21a58:  [<6002023a>] set_signals+0x1c/0x2e
> 6fc21a78:  [<6003644f>] force_sig_info+0xb0/0xbf
> 6fc21ae8:  [<60013a26>] fatal_sigsegv+0x28/0x2d
> 6fc21b08:  [<60022647>] wait_stub_done+0xbd/0xc8
> 6fc21b48:  [<60021dd0>] do_syscall_stub+0xbb/0x1b6
> 6fc21b88:  [<60022032>] run_syscall_stub+0xd1/0xdd
> 6fc21bc8:  [<60023396>] write_ldt_entry+0x111/0x180
> 6fc21c48:  [<600235e4>] init_new_ldt+0x1df/0x303
> 6fc21c68:  [<60053cd6>] __alloc_pages_internal+0x9a/0x36e
> 6fc21cb8:  [<60053fc0>] __alloc_pages+0xb/0xd
> 6fc21d18:  [<60013fa4>] init_new_context+0xc9/0x10d
> 6fc21d28:  [<6002ab7b>] mm_alloc+0x4c/0x53
> 6fc21d58:  [<600711ce>] bprm_mm_init+0x4c/0x168
> 6fc21da8:  [<60071f6a>] do_execve+0x89/0x1db
> 6fc21dd8:  [<6000a854>] tcp_congestion_default+0x0/0x10
> 6fc21df8:  [<60010257>] execve1+0x27/0x42
> 6fc21e28:  [<600102cf>] um_execve+0xd/0x36
> 6fc21e38:  [<6006b945>] do_sys_open+0xc9/0xd8
> 6fc21e48:  [<60012354>] kernel_execve+0x2d/0x38
> 6fc21e78:  [<6000ff72>] run_init_process+0x1a/0x1c
> 6fc21e88:  [<60010029>] init_post+0xb5/0xe0
> 6fc21ea8:  [<60001574>] kernel_init+0x1d8/0x1e9
> 6fc21f48:  [<6001f309>] run_kernel_thread+0x41/0x4a
> 6fc21f58:  [<6000139c>] kernel_init+0x0/0x1e9
> 6fc21f98:  [<6001f2f0>] run_kernel_thread+0x28/0x4a
> 6fc21fc8:  [<600114be>] new_thread_handler+0x67/0x91
>
> Terminated
>   
Just want to mention that the stack trace looks identical here (using 
the 2.6.26 stable kernel)...
> Is there a plan to fix this for the 2.6.26 stable ?
>
> Please forgive me if this is old news and it's already
> been reported.
>
> Boaz
>   


-- 
Mit freundlichen Grüßen
Jürgen Kadidlo
---
Jürgen Kadidlo (Dipl.Inf.)
Developer
COS

EXASOL AG
Neumeyerstrasse 48
D-90411 Nürnberg

T   +49 911 23991 275
F   +49 911 23991 5275
juergen.kadidlo@exasol.com
www.exasol.com

Vorstand: Gerhard Rumpff (Vorsitzender), Dr. Gerhard Bolenz
Aufsichtsratsvorsitzender: Jochen Tschunke
Registergericht Nürnberg HRB 23037
Ust-IdNr.: DE251481716
Diese E-Mail kann vertrauliche Informationen enthalten. Falls Sie nicht der beabsichtigte Empfänger sind, informieren Sie uns bitte sofort und löschen Sie diese Email. Jede unberechtigte Kopie oder Weiterleitung dieser E-Mail ist untersagt.
This e-mail may contain confidential information. If you are not the intended recipient please notify the sender immediately. Any unauthorised copying or distribution of this e-mail is forbidden.








--------------080002030609000609080001
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Boaz Harrosh schrieb:
<blockquote cite="mid:4899C293.7070501@panasas.com" type="cite">
  <pre wrap=""><a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a> wrote:
&lt;snip&gt;
  </pre>
  <blockquote type="cite">
    <pre wrap="">except for the 2.6.26 which still exits with a panic on startup...

    </pre>
  </blockquote>
  <pre wrap=""><!---->
BTW: v2.6.26 checkout from Linus git crashes for me too
2.6.27-rc1 is fine (except it has another problem which I'm bisecting now)

here is the BUG_ON trace:
Stub registers -
        0 - 0
        1 - 0
        2 - 0
        3 - 0
        4 - 0
        5 - 0
        6 - 0
        7 - 0
        8 - 0
        9 - 0
        10 - 0
        11 - 0
        12 - 0
        13 - 0
        14 - 0
        15 - ffffffffffffffff
        16 - 0
        17 - 33
        18 - 10216
        19 - 2aaaaaab0f30
        20 - 2b
        21 - 2aaaaaaad910
        22 - 0
        23 - 0
        24 - 0
        25 - 0
        26 - 0
wait_stub_done : failed to wait for SIGTRAP, pid = 1348, n = 1348, errno = 0, status = 0xb7f
Kernel panic - not syncing: Attempted to kill init!

Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.26
RIP: 0033:[&lt;000000319e430a57&gt;]
RSP: 00007fff26d69cd8  EFLAGS: 00000206
RAX: 0000000000000000 RBX: 000000000000053e RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 000000000000053e
RBP: 00007fff26d69d00 R08: 0000000000000000 R09: 00007fff26d69d00
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000053a
R13: 0000000000000004 R14: 00007fff26d6b58c R15: 00007fff26d69fc0
Call Trace:
6fc21778:  [&lt;60013bc1&gt;] panic_exit+0x2f/0x45
6fc21798:  [&lt;600412f5&gt;] notifier_call_chain+0x33/0x5b
6fc217d8:  [&lt;60041326&gt;] __atomic_notifier_call_chain+0x9/0xb
6fc217e8:  [&lt;60041337&gt;] atomic_notifier_call_chain+0xf/0x11
6fc217f8:  [&lt;6002b8a1&gt;] panic+0xe6/0x17d
6fc21818:  [&lt;60053abe&gt;] get_page_from_freelist+0x2a1/0x41f
6fc218b8:  [&lt;6006a144&gt;] kmem_cache_free+0x55/0x5e
6fc218e8:  [&lt;6002eca3&gt;] do_exit+0x6b/0x694
6fc21908:  [&lt;60036bcd&gt;] __dequeue_signal+0x10e/0x172
6fc21958:  [&lt;6002f35c&gt;] do_group_exit+0x90/0xbf
6fc21998:  [&lt;60037c30&gt;] get_signal_to_deliver+0x2ca/0x318
6fc219b8:  [&lt;60026b7f&gt;] wake_up_state+0xb/0xd
6fc219f8:  [&lt;6001202d&gt;] do_signal+0x1f8/0x2ca
6fc21a58:  [&lt;6002023a&gt;] set_signals+0x1c/0x2e
6fc21a78:  [&lt;6003644f&gt;] force_sig_info+0xb0/0xbf
6fc21ae8:  [&lt;60013a26&gt;] fatal_sigsegv+0x28/0x2d
6fc21b08:  [&lt;60022647&gt;] wait_stub_done+0xbd/0xc8
6fc21b48:  [&lt;60021dd0&gt;] do_syscall_stub+0xbb/0x1b6
6fc21b88:  [&lt;60022032&gt;] run_syscall_stub+0xd1/0xdd
6fc21bc8:  [&lt;60023396&gt;] write_ldt_entry+0x111/0x180
6fc21c48:  [&lt;600235e4&gt;] init_new_ldt+0x1df/0x303
6fc21c68:  [&lt;60053cd6&gt;] __alloc_pages_internal+0x9a/0x36e
6fc21cb8:  [&lt;60053fc0&gt;] __alloc_pages+0xb/0xd
6fc21d18:  [&lt;60013fa4&gt;] init_new_context+0xc9/0x10d
6fc21d28:  [&lt;6002ab7b&gt;] mm_alloc+0x4c/0x53
6fc21d58:  [&lt;600711ce&gt;] bprm_mm_init+0x4c/0x168
6fc21da8:  [&lt;60071f6a&gt;] do_execve+0x89/0x1db
6fc21dd8:  [&lt;6000a854&gt;] tcp_congestion_default+0x0/0x10
6fc21df8:  [&lt;60010257&gt;] execve1+0x27/0x42
6fc21e28:  [&lt;600102cf&gt;] um_execve+0xd/0x36
6fc21e38:  [&lt;6006b945&gt;] do_sys_open+0xc9/0xd8
6fc21e48:  [&lt;60012354&gt;] kernel_execve+0x2d/0x38
6fc21e78:  [&lt;6000ff72&gt;] run_init_process+0x1a/0x1c
6fc21e88:  [&lt;60010029&gt;] init_post+0xb5/0xe0
6fc21ea8:  [&lt;60001574&gt;] kernel_init+0x1d8/0x1e9
6fc21f48:  [&lt;6001f309&gt;] run_kernel_thread+0x41/0x4a
6fc21f58:  [&lt;6000139c&gt;] kernel_init+0x0/0x1e9
6fc21f98:  [&lt;6001f2f0&gt;] run_kernel_thread+0x28/0x4a
6fc21fc8:  [&lt;600114be&gt;] new_thread_handler+0x67/0x91

Terminated
  </pre>
</blockquote>
Just want to mention that the stack trace looks identical here (using
the 2.6.26 stable kernel)...<br>
<blockquote cite="mid:4899C293.7070501@panasas.com" type="cite">
  <pre wrap="">
Is there a plan to fix this for the 2.6.26 stable ?

Please forgive me if this is old news and it's already
been reported.

Boaz
  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Mit freundlichen Grüßen
Jürgen Kadidlo
---
Jürgen Kadidlo (Dipl.Inf.)
Developer
COS

EXASOL AG
Neumeyerstrasse 48
D-90411 Nürnberg

T   +49 911 23991 275
F   +49 911 23991 5275
<a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a>
<a class="moz-txt-link-abbreviated" href="http://www.exasol.com">www.exasol.com</a>

Vorstand: Gerhard Rumpff (Vorsitzender), Dr. Gerhard Bolenz
Aufsichtsratsvorsitzender: Jochen Tschunke
Registergericht Nürnberg HRB 23037
Ust-IdNr.: DE251481716
Diese E-Mail kann vertrauliche Informationen enthalten. Falls Sie nicht der beabsichtigte Empfänger sind, informieren Sie uns bitte sofort und löschen Sie diese Email. Jede unberechtigte Kopie oder Weiterleitung dieser E-Mail ist untersagt.
This e-mail may contain confidential information. If you are not the intended recipient please notify the sender immediately. Any unauthorised copying or distribution of this e-mail is forbidden.






</pre>
</body>
</html>

--------------080002030609000609080001--


--===============0504124794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0504124794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0504124794==--

