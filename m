Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTkZ7-0006WW-Lc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:22:57 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CTkZ6-0000QB-IF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:22:57 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] uml: fail xterm_open when we have no $DISPLAY
References: <20041115032541.GA13077@taniwha.stupidest.org>
In-Reply-To: <20041115032541.GA13077@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151824.29365.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Nov 2004 18:24:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On Monday 15 November 2004 04:25, Chris Wedgwood wrote:
> If UML wants to open an xterm channel and the xterm does not run
> properly (eg. terminates soon after starting) we will get a hang.
> This avoids the most common cause for this and adds a comment (which
> long term will go away with a rewrite of that code I guess?)

Thanks for drawing attention on this! I hadn't had the time to dig this out... 
for now reasonably correct, but no time to review it properly now. The review 
would probably try to find a more direct fix to this...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
