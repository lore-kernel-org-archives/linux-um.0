Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hnmb2-00044S-Vv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 May 2007 19:17:05 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hnmay-0006Vb-6i
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 May 2007 19:17:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 15 May 2007 04:16:51 +0200
References: <alpine.DEB.0.99.0705111619000.15552@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.0.99.0705111619000.15552@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705150416.51779.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch] um: use __used attribute
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@karaya.com>, David Rientjes <rientjes@google.com>

On sabato 12 maggio 2007, David Rientjes wrote:
> Use the newly introduced __used attribute in place of the deprecated
> __attribute_used__.  Functionally the same.
>
> Signed-off-by: David Rientjes <rientjes@google.com>
Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
