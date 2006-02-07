Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6YRD-0004bg-Kl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 11:23:43 -0800
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F6YRD-0002dA-5X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 11:23:43 -0800
Received: by wproxy.gmail.com with SMTP id 68so1321209wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 07 Feb 2006 11:23:42 -0800 (PST)
Message-ID: <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
From: Ulrich Drepper <drepper@gmail.com>
In-Reply-To: <20060207185707.GB6841@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
	<20060207185707.GB6841@ccure.user-mode-linux.org>
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
Date: Tue, 7 Feb 2006 11:23:42 -0800
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 2/7/06, Jeff Dike <jdike@addtoit.com> wrote:
> Nope, that would be the next step if this turned out to be untenable,
> which I guess it is.

You have to do it if you want to keep using the setjmp interface.


> You're actually encrypting them somehow?  How?  And why?

For security reasons.


> Is there a reason there can't be an API for looking at the contents of
> a jmp_buf?

It's not needed.  There is no reason to look at the content of the
struct except if you do something which isn't guaranteed by the spec. 
I'll definitely not add such an interface.  If you need this
functionality, implement it yourself.  setjmp is most likely overkill
anyway.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
