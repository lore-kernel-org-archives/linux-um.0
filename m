Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUs1i-00074g-OE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 11:33:06 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUs1g-0002jS-LM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 11:33:06 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UID's no longer carried over hostfs?
References: <Pine.LNX.4.58.0411181339460.4151@sparrow>
In-Reply-To: <Pine.LNX.4.58.0411181339460.4151@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411182034.58952.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Nov 2004 20:34:58 +0100
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 18 November 2004 19:57, William Stearns wrote:
> Good day, all,
>
>  On the host:
>
> drwxr-xr-x    3 spamgate spamgate   184320 Nov 18 13:27 .
> drwxr-xr-x    3 spamgate spamgate     4096 Jun  6 19:20 ..
> drwxr-xr-x    4 spamgate spamgate  2170880 Nov 16 00:05 archives
> -rw-rw-r--    1 spamgate spamgate    55975 Apr  4  2004
> bogus-domain-info.txt -rw-rw-r--    1 spamgate spamgate   209393 Nov 15 
> 2003 confused_spammer.jpg -rw-rw-r--    1 spamgate spamgate     3251 Nov 15
>  2003 confused_spammer.thumb.jpg

>  I was used to the behavior that UID's were carried by hostfs
> verbatim, and this allowed the "processing" user or root to write out to
> the host.  With 2.4.27 decreeing that all files are owned by root, I can't
> do this any more.
>  Cheers,
>  - Bill
Hmmm, this may be done on purpose (no idea) - I don't know why Jeff did that, 
but probably this should at least be configurable.

If 2.4.24-1um still works like 2.4.23, i.e. like you want, then 2.4.27-bs* 
will work, too: from -bs* I'm excluding all hostfs related changed, since 
they make hostfs very unstable (and not for this problem, for a lot of other 
ones).

Bye
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
