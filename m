Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6XFP-0005AO-1j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 10:07:27 -0800
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F6XFN-0008VN-1s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 10:07:27 -0800
Received: by wproxy.gmail.com with SMTP id 68so1305259wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 07 Feb 2006 10:07:19 -0800 (PST)
Message-ID: <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
From: Ulrich Drepper <drepper@gmail.com>
In-Reply-To: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 2/8] UML - Define jmpbuf access constants
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
Date: Tue, 7 Feb 2006 09:37:13 -0800
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 2/6/06, Jeff Dike <jdike@addtoit.com> wrote:
> With newer libcs, the JB_* macros (which we shouldn't be using anyway,
> probably) go away.

I assume you have your own setjmp implementation and are not using the
libc version?

If you don't then there is a problem.  There is a good reason why the
constants are removed: you couldn't use the values anyway.  Your don't
have the information to "decrypt" them.  If you just used the values
and implemented the function yourself, fine.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
