Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ex5qL-0000XY-DA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2006 09:02:33 -0800
Received: from nproxy.gmail.com ([64.233.182.198])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ex5qC-0003Mv-G8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2006 09:02:30 -0800
Received: by nproxy.gmail.com with SMTP id c29so302746nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Jan 2006 09:02:18 -0800 (PST)
Message-ID: <3524bf1f0601120902v3812029l4d8ba5411b53f36f@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] high-performance system calls using vsyscall
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
Date: Thu, 12 Jan 2006 12:02:16 -0500
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi, all,

I found an old post discussing the possibility of turning a system
call into a procedure call using vsyscall. Is it really implemented in
recent versions? I tested with recent Linux/UML kernels and glibcs but
system calls don't seem that fast. so, i guess it's not implemented
yet?

-Young

From: Jeff Dike <jdike@ka...>
 Re: sysenter and int 80
2002-12-26 11:18
 jonsmirl@ya... said:
 > Is this new page mapping going to effect UML?
 > http://lwn.net/Articles/17931/

 Yup.

 I can use that page to turn a system call into a procedure call.  Highly
 insecure, but the performance will rock.

 				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
