Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWMDk-0005Be-R9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 13:59:40 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CWMDi-0008QQ-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 13:59:40 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <41A23722.7060002@fujitsu-siemens.com>
In-Reply-To: <41A23722.7060002@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411222301.47216.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Problems in make
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
Date: Mon, 22 Nov 2004 23:01:46 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Monday 22 November 2004 19:59, Bodo Stroesser wrote:
> If arch/um/kernel/tt/include/mode-tt.h is changed, make doesn't compile
> tracer.c, the resulting kernel is inconsistent and crashes!

This is true for any dependency of files listed in USER_OBJS, which is broken. 
This problem is known and is pending fixing (and fixing requires designing a 
clean and Kbuild-supported replacement of USER_OBJS). I fixed it some time 
ago, around 2.6.1, but the fix was not integrated because it was too 
invasive.

So: use always make clean ARCH=um before rebuilding (this even holds for 
dependencies on CONFIG_*).

If that slows you down too much, then install ccache (I'm not explaining it 
here because there is nothing special on ccache with kernel compilation and 
because there is plenty of tutorials onto the net).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
