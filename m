Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQt6h-00014O-JO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 12:21:31 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQt6g-0004yV-KU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 12:21:30 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4KJLTp12792
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 May 2004 21:21:29 +0200
From: Henrik Nordstrom <uml@hno.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405202119050.12725-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811839-1663457734-1085080889=:12725"
Subject: [uml-devel] uml 2.4.26-1 hostfs patch #2
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
Date: Thu, 20 May 2004 21:21:29 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1663457734-1085080889=:12725
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here is a second patch to hostfs in 2.4.26-1. This time the permission 
check was implemented wrongly (parameter order mismatch, all int's so 
compiler did not notice).

Also archived on our patch page

  http://marasystems.com/download/uml/

Regards
Henrik

---1463811839-1663457734-1085080889=:12725
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="13-hostfs_access.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0405202121290.12725@filer.marasystems.com>
Content-Description: 
Content-Disposition: attachment; filename="13-hostfs_access.patch"

LS0tIGxpbnV4LTIuNC4yNi11bWxoaXBhYy9hcmNoL3VtL2ZzL2hvc3Rmcy9l
eHRlcm5mcy5jLm9yaWcJVHVlIE1heSAxOCAwMDoxMDo0MiAyMDA0DQorKysg
bGludXgtMi40LjI2LXVtbGhpcGFjL2FyY2gvdW0vZnMvaG9zdGZzL2V4dGVy
bmZzLmMJVGh1IE1heSAyMCAyMToxMjo1NCAyMDA0DQpAQCAtOTYxLDcgKzk2
MSw3IEBADQogCWlmKG5hbWUgPT0gTlVMTCkgDQogCQlyZXR1cm4oLUVOT01F
TSk7DQogDQotCWVyciA9ICgqb3BzLT5hY2Nlc3NfZmlsZSkobmFtZSwgciwg
dywgeCwgY3VycmVudC0+ZnN1aWQsIGN1cnJlbnQtPmZzZ2lkLA0KKwllcnIg
PSAoKm9wcy0+YWNjZXNzX2ZpbGUpKG5hbWUsIGN1cnJlbnQtPmZzdWlkLCBj
dXJyZW50LT5mc2dpZCwgciwgdywgeCwNCiAJCQkJICBtb3VudCk7DQogCWtm
cmVlKG5hbWUpOw0KIA0K
---1463811839-1663457734-1085080889=:12725--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
