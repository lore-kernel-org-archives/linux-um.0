Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQg3f-0004Nd-7U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 03:15:55 -0700
Received: from dns1.exasol.com ([62.146.138.134])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQg3c-00015c-2U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 03:15:55 -0700
Received: from dns1.exasol.com (root@localhost)
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m76AFVha026519 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 12:15:31 +0200
Received: from mail2 (fwgw.exasol.com [62.146.138.137])
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m76AFU8H026508 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 12:15:31 +0200
Message-ID: <489979BD.7060103@exasol.com>
Date: Wed, 06 Aug 2008 12:15:25 +0200
From: juergen.kadidlo@exasol.com
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com> <48988612.3030204@panasas.com>
In-Reply-To: <48988612.3030204@panasas.com>
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
Content-Type: multipart/mixed; boundary="===============1834426431=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1834426431==
Content-Type: multipart/alternative;
	boundary="------------020800080007040501020208"

This is a multi-part message in MIME format.
--------------020800080007040501020208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Boaz Harrosh wrote:

>juergen.kadidlo@exasol.com wrote:
>  
>
>>Boaz Harrosh wrote:
>>    
>>
>>>juergen.kadidlo@exasol.com wrote:
>>>  
>>>      
>>>
>>>>Hi!
>>>>
>>>> I've compiled an UML kernel based on 2.6.25 but loading kernel modules 
>>>>seems to be broken. No matter which module I try to load the output 
>>>>looks similar to this:
>>>>
>>>> overflow in relocation type 11 val 80836d41
>>>>'loop' likely not compiled with -mcmodel=kernel
>>>>
>>>>After searching for a while I found some threads from 2006 discussing 
>>>>this issue, e.g.:
>>>>http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html
>>>>and
>>>>http://marc.info/?l=user-mode-linux-devel&m=115125101012707&w=2
>>>>
>>>>As Andi Kleen has mentioned in a mail from the first thread, simply 
>>>>appending "-mcmodel=kernel" to the KBUILD_CFLAGS does not work (I tried 
>>>>it anyway and can confirm his statement ;)
>>>>
>>>>Since I could not find any solution I've decided to write this mail and 
>>>>ask about the current state of this issue and of course for a solution! 
>>>>I simply don't want to believe that there is no loadable module support 
>>>>for UML in 2008...
>>>>
>>>>Regards
>>>>JK
>>>>
>>>>    
>>>>        
>>>>
>>>Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
>>>are you using?
>>>
>>>I'm using out-of-tree modules with uml for every kernel since 2.6.19.
>>>I have both Host and UML as x86_64 on FC7 with gcc 4.1.2
>>>
>>>Boaz
>>>
>>>  
>>>      
>>>
>>I'm glad to here that the bug has been fixed. Anyway, it does not work
>>with my configuration:
>>
>> - CentOS 5.1 as host system and UML root fs
>> - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
>> - GCC 4.1.2
>> - GLIBC 2.5
>>
>>Regards
>>JK
>>
>>    
>>
>
>I used to run with red-hat 4.5 so this should work.
>64 bit, right?
>
From passed experience I've seen that UML will only
>work if I first do "make ARCH=um defconfig"  and then
>manually enable any needed options with make xconfig.
>other wise it breaks in all kind of ways. Even doing
>a make oldconfig on a good uml config file from older
>kernel will not work. Try to do defconfig and see if
>it loads at all.
>
>How do you compile and run the out-of-tree module
>or is it one of the built in modules?
>
>Boaz
>
>  
>
I tried what you've suggested and did the following:
- make mrproper
- make defconfig ARCH=um
- make linux ARCH=um
- make modules ARCH=um
- make modules_install INSTALL_MOD_PATH=/path/to/mounted/uml_root_fs ARCH=um

It did not work (same result).

After that, I copied the kernel source to the uml-root-fs, started the 
UML and did a 'make clean' and 'make modules ARCH=um' inside the running 
UML, followed by a 'make modules_install'. Again, it did not work.

After that, I've extracted the kernel source again (completely vanilla) 
and restarted at 'make defconfig'. Same result.
No module is loadable. They all have 'invalid fomrat' an the usage of 
the '-mcmodel=kernel' flag is suggested.

BTW : with the same sources (and the same commands as listed above) I've 
successfully built a fully working 32 bit UML kernel!

I've also tried kernel 2.6.24.7 with identical results.

Last but not least, I've tried the same with a fresh download of the 
2.6.26 kernel. Unfortunately, this time there was another problem: the 
kernel exits with a panic on startup (tried to build it twice with the 
same result). According to the stack-trace, the panic happens somewhere 
inside "get_page_from_free_list()"...

I'm really running out of ideas right now, does anyone have some 
suggestions?

Regards
JK
 





--------------020800080007040501020208
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
<blockquote cite="mid48988612.3030204@panasas.com" type="cite">
  <pre wrap=""><a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Boaz Harrosh wrote:
    </pre>
    <blockquote type="cite">
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
      <pre wrap="">Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
are you using?

I'm using out-of-tree modules with uml for every kernel since 2.6.19.
I have both Host and UML as x86_64 on FC7 with gcc 4.1.2

Boaz

  
      </pre>
    </blockquote>
    <pre wrap="">I'm glad to here that the bug has been fixed. Anyway, it does not work
with my configuration:

 - CentOS 5.1 as host system and UML root fs
 - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
 - GCC 4.1.2
 - GLIBC 2.5

Regards
JK

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I used to run with red-hat 4.5 so this should work.
64 bit, right?

From passed experience I've seen that UML will only
work if I first do "make ARCH=um defconfig"  and then
manually enable any needed options with make xconfig.
other wise it breaks in all kind of ways. Even doing
a make oldconfig on a good uml config file from older
kernel will not work. Try to do defconfig and see if
it loads at all.

How do you compile and run the out-of-tree module
or is it one of the built in modules?

Boaz

  </pre>
</blockquote>
I tried what you've suggested and did the following:<br>
- make mrproper<br>
- make defconfig ARCH=um<br>
- make linux ARCH=um<br>
- make modules ARCH=um<br>
- make modules_install INSTALL_MOD_PATH=/path/to/mounted/uml_root_fs
ARCH=um<br>
<br>
It did not work (same result).<br>
<br>
After that, I copied the kernel source to the uml-root-fs, started the
UML and did a 'make clean' and 'make modules ARCH=um' inside the
running UML, followed by a 'make modules_install'. Again, it did not
work.<br>
<br>
After that, I've extracted the kernel source again (completely vanilla)
and restarted at 'make defconfig'. Same result.<br>
No module is loadable. They all have 'invalid fomrat' an the usage of
the '-mcmodel=kernel' flag is suggested.<br>
<br>
BTW : with the same sources (and the same commands as listed above)
I've successfully built a fully working 32 bit UML kernel!<br>
<br>
I've also tried kernel 2.6.24.7 with identical results.<br>
<br>
Last but not least, I've tried the same with a fresh download of the
2.6.26 kernel. Unfortunately, this time there was another problem: the
kernel exits with a panic on startup (tried to build it twice with the
same result). According to the stack-trace, the panic happens somewhere
inside "get_page_from_free_list()"...<br>
<br>
I'm really running out of ideas right now, does anyone have some
suggestions?<br>
<br>
Regards<br>
JK<br>
 <br>
<br>
<br>
<br>
<pre class="moz-signature" cols="72">

</pre>
</body>
</html>

--------------020800080007040501020208--


--===============1834426431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1834426431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1834426431==--

