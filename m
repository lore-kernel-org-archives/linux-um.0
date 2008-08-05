Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQPXS-0000EH-SB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:37:34 -0700
Received: from dns1.exasol.com ([62.146.138.134])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQPXR-0000f4-41
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:37:34 -0700
Received: from dns1.exasol.com (root@localhost)
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m75GbOiw013085 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Aug 2008 18:37:24 +0200
Received: from mail2 (fwgw.exasol.com [62.146.138.137])
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m75GbNCV013061 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Aug 2008 18:37:24 +0200
Message-ID: <489881BE.9070506@exasol.com>
Date: Tue, 05 Aug 2008 18:37:18 +0200
From: juergen.kadidlo@exasol.com
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
In-Reply-To: <489873E0.9030801@panasas.com>
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
Content-Type: multipart/mixed; boundary="===============0404056902=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0404056902==
Content-Type: multipart/alternative;
	boundary="------------030107060409000003090506"

This is a multi-part message in MIME format.
--------------030107060409000003090506
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Boaz Harrosh wrote:

>juergen.kadidlo@exasol.com wrote:
>  
>
>>Hi!
>>
>> I've compiled an UML kernel based on 2.6.25 but loading kernel modules 
>>seems to be broken. No matter which module I try to load the output 
>>looks similar to this:
>>
>> overflow in relocation type 11 val 80836d41
>>'loop' likely not compiled with -mcmodel=kernel
>>
>>After searching for a while I found some threads from 2006 discussing 
>>this issue, e.g.:
>>http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html
>>and
>>http://marc.info/?l=user-mode-linux-devel&m=115125101012707&w=2
>>
>>As Andi Kleen has mentioned in a mail from the first thread, simply 
>>appending "-mcmodel=kernel" to the KBUILD_CFLAGS does not work (I tried 
>>it anyway and can confirm his statement ;)
>>
>>Since I could not find any solution I've decided to write this mail and 
>>ask about the current state of this issue and of course for a solution! 
>>I simply don't want to believe that there is no loadable module support 
>>for UML in 2008...
>>
>>Regards
>>JK
>>
>>    
>>
>
>Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
>are you using?
>
>I'm using out-of-tree modules with uml for every kernel since 2.6.19.
>I have both Host and UML as x86_64 on FC7 with gcc 4.1.2
>
>Boaz
>
>  
>
I'm glad to here that the bug has been fixed. Anyway, it does not work 
with my configuration:

 - CentOS 5.1 as host system and UML root fs
 - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
 - GCC 4.1.2
 - GLIBC 2.5

Regards
JK







--------------030107060409000003090506
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Boaz Harrosh wrote:
<blockquote cite="mid489873E0.9030801@panasas.com" type="cite">
  <pre wrap=""><a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi!

 I've compiled an UML kernel based on 2.6.25 but loading kernel modules 
seems to be broken. No matter which module I try to load the output 
looks similar to this:

 overflow in relocation type 11 val 80836d41
'loop' likely not compiled with -mcmodel=kernel

After searching for a while I found some threads from 2006 discussing 
this issue, e.g.:
<a class="moz-txt-link-freetext" href="http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html">http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html</a>
and
<a class="moz-txt-link-freetext" href="http://marc.info/?l=user-mode-linux-devel&m=115125101012707&w=2">http://marc.info/?l=user-mode-linux-devel&amp;m=115125101012707&amp;w=2</a>

As Andi Kleen has mentioned in a mail from the first thread, simply 
appending "-mcmodel=kernel" to the KBUILD_CFLAGS does not work (I tried 
it anyway and can confirm his statement ;)

Since I could not find any solution I've decided to write this mail and 
ask about the current state of this issue and of course for a solution! 
I simply don't want to believe that there is no loadable module support 
for UML in 2008...

Regards
JK

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
are you using?

I'm using out-of-tree modules with uml for every kernel since 2.6.19.
I have both Host and UML as x86_64 on FC7 with gcc 4.1.2

Boaz

  </pre>
</blockquote>
I'm glad to here that the bug has been fixed. Anyway, it does not work
with my configuration:<br>
<br>
 - CentOS 5.1 as host system and UML root fs <br>
 - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)<br>
 - GCC 4.1.2 <br>
 - GLIBC 2.5<br>
<br>
Regards<br>
JK<br>
<pre class="moz-signature" cols="72">





</pre>
</body>
</html>

--------------030107060409000003090506--


--===============0404056902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0404056902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0404056902==--

