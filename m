Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQdTm-0002hS-B2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 00:30:42 -0700
Received: from dns1.exasol.com ([62.146.138.134])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQdTk-00048P-MG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 00:30:42 -0700
Received: from dns1.exasol.com (root@localhost)
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m767UWwa017841 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 09:30:32 +0200
Received: from mail2 (fwgw.exasol.com [62.146.138.137])
	by dns1.exasol.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m767UVQI017833 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 09:30:32 +0200
Message-ID: <48995312.2050305@exasol.com>
Date: Wed, 06 Aug 2008 09:30:26 +0200
From: juergen.kadidlo@exasol.com
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com>
	<20080805172813.GA9661@c2.user-mode-linux.org>
In-Reply-To: <20080805172813.GA9661@c2.user-mode-linux.org>
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
Content-Type: multipart/mixed; boundary="===============1968618316=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1968618316==
Content-Type: multipart/alternative;
	boundary="------------040602060709030505000400"

This is a multi-part message in MIME format.
--------------040602060709030505000400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Dike wrote:

>On Tue, Aug 05, 2008 at 06:37:18PM +0200, juergen.kadidlo@exasol.com wrote:
>  
>
>>I'm glad to here that the bug has been fixed. Anyway, it does not work  
>>with my configuration:
>>
>>- CentOS 5.1 as host system and UML root fs
>>- Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
>>- GCC 4.1.2
>>- GLIBC 2.5
>>    
>>
>
>I'm not sure that anything was ever broken.
>  
>
According to the links from my first mail, there has been a bug in UML 
that caused that problem and I could not find anything that proved that 
it has been fixed...

>You are building the modules against a UML tree, with ARCH=um on the
>make line?  I.e. you're not trying to load a host module into UML?
>
>     	    	 	    Jeff
>
>  
>
It's not the first time I'm compiling an UML kernel but it is the first 
time I'm building a 64 bit version. Don't get me wrong, I would never 
claim to not make mistakes, but the reason is definitily not a forgotten 
"ARCH=um" or a wrong path, I've triple-checked this...

Regards
JK


--------------040602060709030505000400
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Jeff Dike wrote:
<blockquote cite="mid20080805172813.GA9661@c2.user-mode-linux.org"
 type="cite">
  <pre wrap="">On Tue, Aug 05, 2008 at 06:37:18PM +0200, <a class="moz-txt-link-abbreviated" href="mailto:juergen.kadidlo@exasol.com">juergen.kadidlo@exasol.com</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm glad to here that the bug has been fixed. Anyway, it does not work  
with my configuration:

- CentOS 5.1 as host system and UML root fs
- Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
- GCC 4.1.2
- GLIBC 2.5
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'm not sure that anything was ever broken.
  </pre>
</blockquote>
According to the links from my first mail, there has been a bug in UML
that caused that problem and I could not find anything that proved that
it has been fixed...<br>
<blockquote cite="mid20080805172813.GA9661@c2.user-mode-linux.org"
 type="cite">
  <pre wrap="">
You are building the modules against a UML tree, with ARCH=um on the
make line?  I.e. you're not trying to load a host module into UML?

     	    	 	    Jeff

  </pre>
</blockquote>
It's not the first time I'm compiling an UML kernel but it is the first
time I'm building a 64 bit version. Don't get me wrong, I would never
claim to not make mistakes, but the reason is definitily not a
forgotten "ARCH=um" or a wrong path, I've triple-checked this...<br>
<br>
Regards<br>
JK<br>
<br>
</body>
</html>

--------------040602060709030505000400--


--===============1968618316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1968618316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1968618316==--

