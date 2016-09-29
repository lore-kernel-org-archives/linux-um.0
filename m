Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1bpi4y-00079r-Ou
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 20:37:16 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bpi4x-0003oK-NM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 20:37:16 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Thu, 29 Sep 2016 21:36:56 +0100
Message-Id: <1475181417-26010-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] UBD Improvements (first 30%)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi Richard, hi list.

I had some difficulties evaluating the actual performance
difference because of the strange behaviour with the ubd speed
reduction over time (as per my earlier "There is something rotten"
email).

Overall, if I take the only the first few dd runs to read the
entire disk and compare like for like (first run without patch vs
first run with patch) I get 30% improvement on dd-ing a 16G sparse
ubd device.

The performance on find /usr -type f -exec cat {} > /dev/null \; 
increases 17%.

The patch is called "Phase 1" for a reason - by bulking the requests
we set-up the scene for a later replacement of pread/pwrite with
preadv/pwritev in next series of patches which should increase the
speed further by at least the same amount (if not more).


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

