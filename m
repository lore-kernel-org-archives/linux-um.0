Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTHv9-0008HZ-9L for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Nov 2004 02:47:47 -0800
Received: from [217.204.41.189] (helo=kula.newsnow.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CTHv7-0001uV-Jp
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Nov 2004 02:47:47 -0800
Received: from r3bh172.chello.upc.cz ([213.220.251.172] helo=[192.168.0.4])
	by kula.newsnow.net with esmtp (Exim 3.35 #1 (Debian))
	id 1CTHuz-0000Nj-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Nov 2004 10:47:37 +0000
Message-ID: <419737C6.3060904@praguespringpeople.org>
From: Struan Bartlett <struan@praguespringpeople.org>
MIME-Version: 1.0
References: <418E5CA1.90308@praguespringpeople.org>
In-Reply-To: <418E5CA1.90308@praguespringpeople.org>
Content-Type: multipart/alternative;
	boundary="------------030808080508020209010402"
Subject: [uml-devel] 2.4.27 guest bug reconfirmed Re bug report [ 745826 ] run
	cat /dev/urandom
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 Nov 2004 11:47:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030808080508020209010402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've now tested for this bug using a simplified methodology on the 
latest patched-versions of the host (2.4.27 and 2.6.8) and guest (2.4.27 
and 2.6.9).

_New methodology_

My Debian guest system raises two xterms at startup. On each I log in as 
root. On one, I enter:

while true; do echo >/dev/null; done

On the second, I enter:

cat /dev/urandom

The devastating symptom: within 5 seconds the guest kernel has paniced 
and exited with the message (below) "kernel BUG at sched.c:564!".

_Findings_

guest 2.6.9: patched with uml-2.6.9-bb2.patch.bz2 - I am pleased to say 
I have not so far been able to reproduce this bug on this configuration.

guest 2.4.27: patched with uml-2.4.27-bs1.patch and 
uml-patch-2.4.24-1base.patch - no change; this bug is readily 
reproducible and so IS NOT FIXED, regardless of whether the guest is run 
on host 2.4.27 or 2.6.8

_Conclusion_

If such a simple pair of commands as this causes such devastating 
consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be 
taken a look at - unless, that is, Jeff Dike's recent post about 
uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.

Jeff: where can I get your uml-patch-2.4.27-1 ?

Struan

Struan Bartlett wrote:

> Posted to SourceForge:
>
> For the record, this is not entirely fixed. I'm running a Debian host
> with 2.4.25 kernel and host-skas3-2.4.25.patch, and a Debian
> guest with 2.4.27 kernel and uml-patch-2.4.26-3.
>
> In one xterm I ran "while true; do ls -la /dev/*; done" (see
> also bug report 617709). In the other, "cat /dev/urandom".
> After 5-10 seconds, the 'linux' host process crashes
> completely with:
>
> Scheduling in interrupt
> Kernel panic: kernel BUG at sched.c:564!
>
> In interrupt handler - not syncing
> <6>SysRq : Show Regs
>
> EIP: 0023:[<400e4b38>] CPU: 0 Not tainted ESP: 002b:bffffc68
> EFLAGS: 00000246
>    Not tainted
> EAX: ffffffda EBX: 00000001 ECX: 0804cdf0 EDX: 00001000
> ESI: 00001000 EDI: 0804cdf0 EBP: bffffc88 DS: 002b ES: 002b
> Call Trace: [<a0010e5f>] [<a00cae60>] [<a018db51>]
> [<a018dade>] [<a000dc93>]   [<a00cade9>] [<a00b526f>] [<a0010e5f>] 
> [<a001d2ec>]
> [<a012d637>] [<a017561e>]   [<a0010e5f>] [<a017561e>] [<a0010405>] 
> [<a00103f1>]
> [<a0010e5f>] [<a000d965>]   [<a017561e>] [<a0175616>] [<a00b26ec>] 
> [<a00bd0d1>]
> [<a0015e2f>] [<a00bd268>]   [<a00e1fc4>] [<a00b4caf>] [<a00e0057>] 
> [<a00c32d5>]
> [<a00b4caf>] [<a00c3a6a>]   [<a012f024>] [<a00c42e2>] [<a00b2816>] 
> [<a00b2855>]
> [<a00b277e>] [<a00c3035>]   [<a00c8bc0>] [<a001622f>] [<a001a8e3>] 
> [<a0016153>]
> [<a001607b>] [<a0016037>]   [<a00b26ec>] [<a0015de1>] [<a0015dcf>] 
> [<a00ada41>]
> [<a00ada52>] [<a00b3dfe>]   [<a00b4108>] [<a00bb278>] [<a00bb211>] 
> [<a00bb211>]
> [<a00bb278>] [<a00b4bed>]   [<a00b4ba8>] [<a012ef38>] [<a014639d>] 
> [<a014639d>]
> [<a012ef38>] [<a00c8db0>]   [<a00bb56e>] [<a00bb3e0>] [<a00bb7f0>] 
> [<a00b0404>]
> [<a00bb7f0>] [<a00bb304>]   [<a0053f2f>] [<a00bb64c>] [<a00ab920>] 
> [<a00b0404>]
> [<a00bb3d4>] [<a00c8c7b>]   [<a00bb304>] [<a00bb458>] [<a00bb59c>] 
> [<a00bb64c>]
> [<a012f024>] [<a00bb59c>]   [<a00bb3d4>] [<a00b0404>] [<a00bb64c>] 
> [<a00bb458>]
> [<a00bb59c>] [<a00bb59c>]   [<a00b597f>] [<a00b2855>] [<a00bb458>] 
> [<a00be776>]
> [<a00be776>] [<a00be81d>]   [<a0146380>] [<a00b0658>] [<a00be81d>] 
> [<a00e031b>]
> [<a00e05d6>] [<a00bb59c>]   [<a00e1458>] [<a00bb637>] [<a00e0057>] 
> [<a00e0057>]
> [<a00c3a29>] [<a00c32d5>]   [<a00c5f3d>] [<a00c5e11>] [<a00c0e91>] 
> [<a00c5d50>]
> [<a0033e1a>] [<a00bad8e>]   [<a00b35bb>] [<a00b36e3>] [<a00baddc>] 
> [<a00badd3>]
> [<a00b9fb5>] [<a00ba0bd>]   [<a00b01ba>] [<a00ba31a>] [<a00b26ec>] 
> [<a00baa87>]
> [<a00baa71>] [<a012ef38>]   [<a012efd1>]
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--------------030808080508020209010402
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I've now tested for this bug using a simplified methodology on the
latest patched-versions of the host (2.4.27 and 2.6.8) and guest
(2.4.27 and 2.6.9).<br>
<br>
<u>New methodology</u><br>
<br>
My Debian guest system raises two xterms at startup. On each I log in
as root. On one, I enter:<br>
<br>
<tt>while true; do echo &gt;/dev/null; done<br>
</tt><br>
On the second, I enter:<br>
<br>
<tt>cat /dev/urandom<br>
</tt><br>
The devastating symptom: within 5 seconds the guest kernel has paniced
and exited with the message (below) "kernel BUG at sched.c:564!".<br>
<br>
<u>Findings</u><br>
<br>
guest 2.6.9: patched with uml-2.6.9-bb2.patch.bz2 - I am pleased to say
I have not so far been able to reproduce this bug on this configuration.<br>
<br>
guest 2.4.27: patched with uml-2.4.27-bs1.patch and
uml-patch-2.4.24-1base.patch - no change; this bug is readily
reproducible and so IS NOT FIXED, regardless of whether the guest is
run on host 2.4.27 or 2.6.8<br>
<br>
<u>Conclusion</u><br>
<br>
If such a simple pair of commands as this causes such devastating
consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be
taken a look at - unless, that is, Jeff Dike's recent post about
uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.<br>
<br>
Jeff: where can I get your uml-patch-2.4.27-1 ?<br>
<br>
Struan<br>
<br>
Struan Bartlett wrote:
<blockquote cite="mid418E5CA1.90308@praguespringpeople.org" type="cite">Posted
to SourceForge:
  <br>
  <br>
For the record, this is not entirely fixed. I'm running a Debian host
  <br>
with 2.4.25 kernel and host-skas3-2.4.25.patch, and a Debian
  <br>
guest with 2.4.27 kernel and uml-patch-2.4.26-3.
  <br>
  <br>
In one xterm I ran "while true; do ls -la /dev/*; done" (see
  <br>
also bug report 617709). In the other, "cat /dev/urandom".
  <br>
After 5-10 seconds, the 'linux' host process crashes
  <br>
completely with:
  <br>
  <br>
Scheduling in interrupt
  <br>
Kernel panic: kernel BUG at sched.c:564!
  <br>
  <br>
In interrupt handler - not syncing
  <br>
&lt;6&gt;SysRq : Show Regs
  <br>
  <br>
EIP: 0023:[&lt;400e4b38&gt;] CPU: 0 Not tainted ESP: 002b:bffffc68
  <br>
EFLAGS: 00000246
  <br>
&nbsp;&nbsp; Not tainted
  <br>
EAX: ffffffda EBX: 00000001 ECX: 0804cdf0 EDX: 00001000
  <br>
ESI: 00001000 EDI: 0804cdf0 EBP: bffffc88 DS: 002b ES: 002b
  <br>
Call Trace: [&lt;a0010e5f&gt;] [&lt;a00cae60&gt;] [&lt;a018db51&gt;]
  <br>
[&lt;a018dade&gt;] [&lt;a000dc93&gt;] &nbsp; [&lt;a00cade9&gt;]
[&lt;a00b526f&gt;] [&lt;a0010e5f&gt;] [&lt;a001d2ec&gt;]
  <br>
[&lt;a012d637&gt;] [&lt;a017561e&gt;] &nbsp; [&lt;a0010e5f&gt;]
[&lt;a017561e&gt;] [&lt;a0010405&gt;] [&lt;a00103f1&gt;]
  <br>
[&lt;a0010e5f&gt;] [&lt;a000d965&gt;] &nbsp; [&lt;a017561e&gt;]
[&lt;a0175616&gt;] [&lt;a00b26ec&gt;] [&lt;a00bd0d1&gt;]
  <br>
[&lt;a0015e2f&gt;] [&lt;a00bd268&gt;] &nbsp; [&lt;a00e1fc4&gt;]
[&lt;a00b4caf&gt;] [&lt;a00e0057&gt;] [&lt;a00c32d5&gt;]
  <br>
[&lt;a00b4caf&gt;] [&lt;a00c3a6a&gt;] &nbsp; [&lt;a012f024&gt;]
[&lt;a00c42e2&gt;] [&lt;a00b2816&gt;] [&lt;a00b2855&gt;]
  <br>
[&lt;a00b277e&gt;] [&lt;a00c3035&gt;] &nbsp; [&lt;a00c8bc0&gt;]
[&lt;a001622f&gt;] [&lt;a001a8e3&gt;] [&lt;a0016153&gt;]
  <br>
[&lt;a001607b&gt;] [&lt;a0016037&gt;] &nbsp; [&lt;a00b26ec&gt;]
[&lt;a0015de1&gt;] [&lt;a0015dcf&gt;] [&lt;a00ada41&gt;]
  <br>
[&lt;a00ada52&gt;] [&lt;a00b3dfe&gt;] &nbsp; [&lt;a00b4108&gt;]
[&lt;a00bb278&gt;] [&lt;a00bb211&gt;] [&lt;a00bb211&gt;]
  <br>
[&lt;a00bb278&gt;] [&lt;a00b4bed&gt;] &nbsp; [&lt;a00b4ba8&gt;]
[&lt;a012ef38&gt;] [&lt;a014639d&gt;] [&lt;a014639d&gt;]
  <br>
[&lt;a012ef38&gt;] [&lt;a00c8db0&gt;] &nbsp; [&lt;a00bb56e&gt;]
[&lt;a00bb3e0&gt;] [&lt;a00bb7f0&gt;] [&lt;a00b0404&gt;]
  <br>
[&lt;a00bb7f0&gt;] [&lt;a00bb304&gt;] &nbsp; [&lt;a0053f2f&gt;]
[&lt;a00bb64c&gt;] [&lt;a00ab920&gt;] [&lt;a00b0404&gt;]
  <br>
[&lt;a00bb3d4&gt;] [&lt;a00c8c7b&gt;] &nbsp; [&lt;a00bb304&gt;]
[&lt;a00bb458&gt;] [&lt;a00bb59c&gt;] [&lt;a00bb64c&gt;]
  <br>
[&lt;a012f024&gt;] [&lt;a00bb59c&gt;] &nbsp; [&lt;a00bb3d4&gt;]
[&lt;a00b0404&gt;] [&lt;a00bb64c&gt;] [&lt;a00bb458&gt;]
  <br>
[&lt;a00bb59c&gt;] [&lt;a00bb59c&gt;] &nbsp; [&lt;a00b597f&gt;]
[&lt;a00b2855&gt;] [&lt;a00bb458&gt;] [&lt;a00be776&gt;]
  <br>
[&lt;a00be776&gt;] [&lt;a00be81d&gt;] &nbsp; [&lt;a0146380&gt;]
[&lt;a00b0658&gt;] [&lt;a00be81d&gt;] [&lt;a00e031b&gt;]
  <br>
[&lt;a00e05d6&gt;] [&lt;a00bb59c&gt;] &nbsp; [&lt;a00e1458&gt;]
[&lt;a00bb637&gt;] [&lt;a00e0057&gt;] [&lt;a00e0057&gt;]
  <br>
[&lt;a00c3a29&gt;] [&lt;a00c32d5&gt;] &nbsp; [&lt;a00c5f3d&gt;]
[&lt;a00c5e11&gt;] [&lt;a00c0e91&gt;] [&lt;a00c5d50&gt;]
  <br>
[&lt;a0033e1a&gt;] [&lt;a00bad8e&gt;] &nbsp; [&lt;a00b35bb&gt;]
[&lt;a00b36e3&gt;] [&lt;a00baddc&gt;] [&lt;a00badd3&gt;]
  <br>
[&lt;a00b9fb5&gt;] [&lt;a00ba0bd&gt;] &nbsp; [&lt;a00b01ba&gt;]
[&lt;a00ba31a&gt;] [&lt;a00b26ec&gt;] [&lt;a00baa87&gt;]
  <br>
[&lt;a00baa71&gt;] [&lt;a012ef38&gt;] &nbsp; [&lt;a012efd1&gt;] <br>
  <br>
  <br>
-------------------------------------------------------
  <br>
This SF.Net email is sponsored by:
  <br>
Sybase ASE Linux Express Edition - download now for FREE
  <br>
LinuxWorld Reader's Choice Award Winner for best database on Linux.
  <br>
<a class="moz-txt-link-freetext" href="http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click">http://ads.osdn.com/?ad_id=5588&amp;alloc_id=12065&amp;op=click</a>
  <br>
_______________________________________________
  <br>
User-mode-linux-devel mailing list
  <br>
<a class="moz-txt-link-abbreviated" href="mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
  <br>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel</a>
  <br>
</blockquote>
</body>
</html>

--------------030808080508020209010402--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
