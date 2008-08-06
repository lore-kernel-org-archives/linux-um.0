Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQi5D-0002cu-UE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:25:41 -0700
Received: from dns1.exasol.com ([62.146.138.134])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQi5B-0003GO-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:25:39 -0700
Received: from dns1.exasol.com (root@localhost)
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m76CPUef009078 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 14:25:30 +0200
Received: from mail2 (fwgw.exasol.com [62.146.138.137])
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m76CPTk9009070 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 14:25:29 +0200
Message-ID: <48999834.1000707@exasol.com>
Date: Wed, 06 Aug 2008 14:25:24 +0200
From: juergen.kadidlo@exasol.com
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com>
	<48988612.3030204@panasas.com> <489979BD.7060103@exasol.com>
	<48998FBD.6080705@panasas.com>
In-Reply-To: <48998FBD.6080705@panasas.com>
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
Content-Type: multipart/mixed; boundary="===============0541521004=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0541521004==
Content-Type: multipart/alternative;
	boundary="------------050507020602000304040408"

This is a multi-part message in MIME format.
--------------050507020602000304040408
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
>>>>Boaz Harrosh wrote:
>>>>    
>>>>        
>>>>
>>>>>juergen.kadidlo@exasol.com wrote:
>>>>>  
>>>>>      
>>>>>          
>>>>>
>>>>>>Hi!
>>>>>>
>>>>>> I've compiled an UML kernel based on 2.6.25 but loading kernel modules 
>>>>>>seems to be broken. No matter which module I try to load the output 
>>>>>>looks similar to this:
>>>>>>
>>>>>> overflow in relocation type 11 val 80836d41
>>>>>>'loop' likely not compiled with -mcmodel=kernel
>>>>>>
>>>>>>After searching for a while I found some threads from 2006 discussing 
>>>>>>this issue, e.g.:
>>>>>>http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html
>>>>>>and
>>>>>>http://marc.info/?l=user-mode-linux-devel&m=115125101012707&w=2
>>>>>>
>>>>>>As Andi Kleen has mentioned in a mail from the first thread, simply 
>>>>>>appending "-mcmodel=kernel" to the KBUILD_CFLAGS does not work (I tried 
>>>>>>it anyway and can confirm his statement ;)
>>>>>>
>>>>>>Since I could not find any solution I've decided to write this mail and 
>>>>>>ask about the current state of this issue and of course for a solution! 
>>>>>>I simply don't want to believe that there is no loadable module support 
>>>>>>for UML in 2008...
>>>>>>
>>>>>>Regards
>>>>>>JK
>>>>>>
>>>>>>    
>>>>>>        
>>>>>>            
>>>>>>
>>>>>Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
>>>>>are you using?
>>>>>
>>>>>I'm using out-of-tree modules with uml for every kernel since 2.6.19.
>>>>>I have both Host and UML as x86_64 on FC7 with gcc 4.1.2
>>>>>
>>>>>Boaz
>>>>>
>>>>>  
>>>>>      
>>>>>          
>>>>>
>>>>I'm glad to here that the bug has been fixed. Anyway, it does not work
>>>>with my configuration:
>>>>
>>>> - CentOS 5.1 as host system and UML root fs
>>>> - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
>>>> - GCC 4.1.2
>>>> - GLIBC 2.5
>>>>
>>>>Regards
>>>>JK
>>>>
>>>>    
>>>>        
>>>>
>>>I used to run with red-hat 4.5 so this should work.
>>>64 bit, right?
>>>
>>>From passed experience I've seen that UML will only
>>>work if I first do "make ARCH=um defconfig"  and then
>>>manually enable any needed options with make xconfig.
>>>other wise it breaks in all kind of ways. Even doing
>>>a make oldconfig on a good uml config file from older
>>>kernel will not work. Try to do defconfig and see if
>>>it loads at all.
>>>
>>>How do you compile and run the out-of-tree module
>>>or is it one of the built in modules?
>>>
>>>Boaz
>>>
>>>  
>>>      
>>>
>>I tried what you've suggested and did the following:
>>- make mrproper
>>- make defconfig ARCH=um
>>- make linux ARCH=um
>>- make modules ARCH=um
>>- make modules_install INSTALL_MOD_PATH=/path/to/mounted/uml_root_fs ARCH=um
>>
>>It did not work (same result).
>>
>>After that, I copied the kernel source to the uml-root-fs, started the
>>UML and did a 'make clean' and 'make modules ARCH=um' inside the running
>>UML, followed by a 'make modules_install'. Again, it did not work.
>>
>>After that, I've extracted the kernel source again (completely vanilla)
>>and restarted at 'make defconfig'. Same result.
>>No module is loadable. They all have 'invalid fomrat' an the usage of
>>the '-mcmodel=kernel' flag is suggested.
>>
>>BTW : with the same sources (and the same commands as listed above) I've
>>successfully built a fully working 32 bit UML kernel!
>>
>>I've also tried kernel 2.6.24.7 with identical results.
>>
>>Last but not least, I've tried the same with a fresh download of the
>>2.6.26 kernel. Unfortunately, this time there was another problem: the
>>kernel exits with a panic on startup (tried to build it twice with the
>>same result). According to the stack-trace, the panic happens somewhere
>>inside "get_page_from_free_list()"...
>>
>>I'm really running out of ideas right now, does anyone have some
>>suggestions?
>>
>>Regards
>>JK
>> 
>>    
>>
>
>It all works down here. Just a long shot you have installed uml_utilities
>on the host ...
>  
>
They are installed.

>I run the uml from the root of the source tree like this:
>.../.build_um/vmlinux ubd0=/usr0/var/local/um/Fedora7-AMD64-root_fs eth0=tuntap,,,192.168.0.117 mem=256M
>(The .build_um/ is because I use KBUILD_OUTPUT=.build_um so I can compile 
>multiple targets from same source tree)
>
>Maybe there is some package missing from the Linux image you are using.
>You are using a 64bit Linux image with your 64bit kernel, yes?
>Try to compare the 32 bit image with the 64bit one. See if they have
>the same packages installed. I started with a ready made fedora7 uml
>image and never really touched it much except the occasional yum install
>of a library or two.
>
>Boaz
>  
>
I already thought about the root fs being the reason for this, but I 
can't imagine how a different root can affect the kernel's ability to 
load modules. It should not be affected by any packages installed, isn't it?
 Anyway, after taking a closer look to your starting command, I noticed 
another difference: I've always been using "mem=512m" on the 64 bit 
system (it's an 8 GB machine). I've tried it with "mem=256" and IT 
FINALLY WORKS! All the kernels I've compiled are working correctly now, 
except for the 2.6.26 which still exits with a panic on startup...

Thank you very much for your help! But I'd really like to know why it 
did not work with "m= 512m". I've always thought that this would only 
alter the max. available memory inside the UML. Maybe this is a bug though?

Regards
JK

--------------050507020602000304040408
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
<blockquote cite="mid48998FBD.6080705@panasas.com" type="cite">
  <pre wrap=""><a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Boaz Harrosh wrote:
    </pre>
    <blockquote type="cite">
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
      <pre wrap="">I used to run with red-hat 4.5 so this should work.
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
    <pre wrap="">I tried what you've suggested and did the following:
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
 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It all works down here. Just a long shot you have installed uml_utilities
on the host ...
  </pre>
</blockquote>
They are installed.<br>
<blockquote cite="mid48998FBD.6080705@panasas.com" type="cite">
  <pre wrap="">
I run the uml from the root of the source tree like this:
......./.build_um/vmlinux ubd0=/usr0/var/local/um/Fedora7-AMD64-root_fs eth0=tuntap,,,192.168.0.117 mem=256M
(The .build_um/ is because I use KBUILD_OUTPUT=.build_um so I can compile 
multiple targets from same source tree)

Maybe there is some package missing from the Linux image you are using.
You are using a 64bit Linux image with your 64bit kernel, yes?
Try to compare the 32 bit image with the 64bit one. See if they have
the same packages installed. I started with a ready made fedora7 uml
image and never really touched it much except the occasional yum install
of a library or two.

Boaz
  </pre>
</blockquote>
I already thought about the root fs being the reason for this, but I
can't imagine how a different root can affect the kernel's ability to
load modules. It should not be affected by any packages installed,
isn't it?<br>
 Anyway, after taking a closer look to your starting command, I noticed
another difference: I've always been using "mem=512m" on the 64 bit
system (it's an 8 GB machine). I've tried it with "mem=256" and IT
FINALLY WORKS! All the kernels I've compiled are working correctly now,
except for the 2.6.26 which still exits with a panic on startup...<br>
<br>
Thank you very much for your help! But I'd really like to know why it
did not work with "m= 512m". I've always thought that this would only
alter the max. available memory inside the UML. Maybe this is a bug
though?<br>
<br>
Regards<br>
JK<br>
</body>
</html>

--------------050507020602000304040408--


--===============0541521004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0541521004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0541521004==--

