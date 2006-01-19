Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzOtR-0007GH-VQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 17:47:17 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzOtQ-0000ls-Mq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 17:47:18 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0601182042120.4057@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] 2.6.16-rc1-um20060118 tls compile problem
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
Date: Wed, 18 Jan 2006 20:46:07 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, Jeff,
 	This is with your quilt set from today.

   CC      arch/um/os-Linux/tls.o
arch/um/os-Linux/tls.c:48: error: syntax error before 'get_thread_area'
arch/um/os-Linux/tls.c:48: warning: type defaults to 'int' in declaration 
of '_syscall1'
arch/um/os-Linux/tls.c:48: warning: function declaration isn't a prototype
arch/um/os-Linux/tls.c:48: warning: data definition has no type or storage 
class
arch/um/os-Linux/tls.c:49: error: syntax error before 'set_thread_area'
arch/um/os-Linux/tls.c:49: warning: type defaults to 'int' in declaration 
of '_syscall1'
arch/um/os-Linux/tls.c:49: warning: function declaration isn't a prototype
arch/um/os-Linux/tls.c:49: warning: data definition has no type or storage 
class
arch/um/os-Linux/tls.c:51: warning: 'struct modify_ldt_t' declared inside 
parameter list
arch/um/os-Linux/tls.c:51: warning: its scope is only this definition or 
declaration, which is probably not what you want
arch/um/os-Linux/tls.c: In function 'do_set_thread_area_tt':
arch/um/os-Linux/tls.c:55: warning: implicit declaration of function 
'set_thread_area'
arch/um/os-Linux/tls.c: At top level:
arch/um/os-Linux/tls.c:62: warning: 'struct modify_ldt_t' declared inside 
parameter list
arch/um/os-Linux/tls.c: In function 'do_get_thread_area_tt':
arch/um/os-Linux/tls.c:66: warning: implicit declaration of function 
'get_thread_area'
make[1]: *** [arch/um/os-Linux/tls.o] Error 1
make: *** [arch/um/os-Linux] Error 2


[root@sparrow ~]# rpm -q gcc glibc-devel glibc-kernheaders
gcc-4.0.2-8.fc4
glibc-devel-2.3.5-10.3
glibc-kernheaders-2.4-9.1.94

 	Please let me know if there's more I can provide or try.  Thanks 
for all your work on this.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
Do you smoke after sex?
Why, do you know, I've never looked!
(Courtesy of Matthias Urlichs <smurf@noris.de>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
