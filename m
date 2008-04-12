Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JkcOE-0005KZ-NR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 02:51:18 -0700
Received: from qb-out-0506.google.com ([72.14.204.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JkcOE-0007c8-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 02:51:18 -0700
Received: by qb-out-0506.google.com with SMTP id c8so851770qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 02:51:15 -0700 (PDT)
Date: Sat, 12 Apr 2008 17:47:33 +0800 (CST)
Message-Id: <20080412.174733.133433510.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] uml: compile error fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1188025975=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

--===============1188025975==
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: base64

DQpUaGlzIHBhdGNoIGZpeGVzIHRoaXMgZXJyb3I6DQoNCiAgQ0MgICAgICBhcmNoL3VtL2tlcm5l
bC9zbXAubw0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9ob21lL3dhbmdjb25nL3Byb2plY3RzL2xp
bnV4LTIuNi9hcmNoL3VtL2tlcm5lbC9zbXAuYzo5Og0KaW5jbHVkZTIvYXNtL3RsYi5oOiBJbiBm
dW5jdGlvbiChrnRsYl9yZW1vdmVfcGFnZaGvOg0KaW5jbHVkZTIvYXNtL3RsYi5oOjEwMTogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIKGucGFnZV9jYWNoZV9yZWxlYXNl
oa8NCm1ha2VbMl06ICoqKiBbYXJjaC91bS9rZXJuZWwvc21wLm9dIEVycm9yIDENCm1ha2VbMV06
ICoqKiBbYXJjaC91bS9rZXJuZWxdIEVycm9yIDINCm1ha2U6ICoqKiBbc3ViLW1ha2VdIEVycm9y
IDINCg0KQW5kIHNpbmNlIGluY2x1ZGluZyA8bGludXgvcGFnZW1hcC5oPiBpbiA8bGludXgvc3dh
cC5oPiB3aWxsIGJyZWFrIHNwYXJjLA0Kd2UgYWRkIHRoaXMgI2luY2x1ZGUgaW4gdW1sJ3Mgb3du
IGhlYWRlci4NCg0KQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRkdG9pdC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBXQU5HIENvbmcgPHdhbmdjb25nQHpldXV4Lm9yZz4NCg0KLS0tDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hc20tdW0vdGxiLmggYi9pbmNsdWRlL2FzbS11bS90bGIuaA0KaW5kZXggMzlmYzQ3
NS4uNTI0MGZhMSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvYXNtLXVtL3RsYi5oDQorKysgYi9pbmNs
dWRlL2FzbS11bS90bGIuaA0KQEAgLTEsNiArMSw3IEBADQogI2lmbmRlZiBfX1VNX1RMQl9IDQog
I2RlZmluZSBfX1VNX1RMQl9IDQogDQorI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4NCiAjaW5j
bHVkZSA8bGludXgvc3dhcC5oPg0KICNpbmNsdWRlIDxhc20vcGVyY3B1Lmg+DQogI2luY2x1ZGUg
PGFzbS9wZ2FsbG9jLmg+DQo=


--===============1188025975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1188025975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1188025975==--
