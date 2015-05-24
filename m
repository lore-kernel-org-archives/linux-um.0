Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ywe87-0007tW-0g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 22:12:23 +0000
Received: from mail-vn0-f41.google.com ([209.85.216.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ywe83-0007F9-EQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 22:12:23 +0000
Received: by vnbf129 with SMTP id f129so4301928vnb.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 24 May 2015 15:12:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyOANSecAV+paVqir17VcaCvWWYXiv6VTSWUni8yeXxHg@mail.gmail.com>
References: <1432473834-26391-1-git-send-email-hwhilse@gmail.com>
	<CAFLxGvyOANSecAV+paVqir17VcaCvWWYXiv6VTSWUni8yeXxHg@mail.gmail.com>
Date: Mon, 25 May 2015 00:12:13 +0200
Message-ID: <CAFLxGvxsYhRfV3aBgGtJmyPjUysnRNEx8TOOcigBZizzwz7+TA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=bcaec51b1a477d5a500516db2fd9
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: handle GCC 5.x like GCC 4.x
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--bcaec51b1a477d5a500516db2fd9
Content-Type: text/plain; charset=UTF-8

On Sun, May 24, 2015 at 6:12 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> Hmm, instead of continue with that hack it would be much nicer to get rid
> of the copy&pasted __user define.

Hans-Werner, can you please give the attached patch a try?
It should fix your issue too.

-- 
Thanks,
//richard

--bcaec51b1a477d5a500516db2fd9
Content-Type: text/plain; charset=US-ASCII; name="uml_cleanup_init.h.diff"
Content-Disposition: attachment; filename="uml_cleanup_init.h.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ia30szeo0

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vTWFrZWZpbGUgYi9hcmNoL3VtL01ha2VmaWxlCmluZGV4IDE3
ZDQ0NjAuLjA5OGFiMzMgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vTWFrZWZpbGUKKysrIGIvYXJjaC91
bS9NYWtlZmlsZQpAQCAtNjgsOSArNjgsMTAgQEAgS0JVSUxEX0NGTEFHUyArPSAkKENGTEFHUykg
JChDRkxBR1MteSkgLURfX2FyY2hfdW1fXyBcCiAKIEtCVUlMRF9BRkxBR1MgKz0gJChBUkNIX0lO
Q0xVREUpCiAKLVVTRVJfQ0ZMQUdTID0gJChwYXRzdWJzdCAkKEtFUk5FTF9ERUZJTkVTKSwsJChw
YXRzdWJzdCAtRF9fS0VSTkVMX18sLFwKLQkkKHBhdHN1YnN0IC1JJSwsJChLQlVJTERfQ0ZMQUdT
KSkpKSAkKEFSQ0hfSU5DTFVERSkgJChNT0RFX0lOQ0xVREUpIFwKLQkkKGZpbHRlciAtSSUsJChD
RkxBR1MpKSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1pZGlyYWZ0ZXIgaW5jbHVkZQorVVNFUl9D
RkxBR1MgPSAkKHBhdHN1YnN0ICQoS0VSTkVMX0RFRklORVMpLCwkKHBhdHN1YnN0IC1JJSwsJChL
QlVJTERfQ0ZMQUdTKSkpIFwKKwkJJChBUkNIX0lOQ0xVREUpICQoTU9ERV9JTkNMVURFKSAkKGZp
bHRlciAtSSUsJChDRkxBR1MpKSBcCisJCS1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLWlkaXJhZnRl
ciBpbmNsdWRlIFwKKwkJLURfX0tFUk5FTF9fIC1EX19VTV9IT1NUX18KIAogI1RoaXMgd2lsbCBh
ZGp1c3QgKkZMQUdTIGFjY29yZGluZ2x5IHRvIHRoZSBwbGF0Zm9ybS4KIGluY2x1ZGUgJChBUkNI
X0RJUikvTWFrZWZpbGUtb3MtJChPUykKZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVycy9tY29u
c29sZS5oIGIvYXJjaC91bS9kcml2ZXJzL21jb25zb2xlLmgKaW5kZXggOGIyMjUzNS4uNDRhZjcz
NyAxMDA2NDQKLS0tIGEvYXJjaC91bS9kcml2ZXJzL21jb25zb2xlLmgKKysrIGIvYXJjaC91bS9k
cml2ZXJzL21jb25zb2xlLmgKQEAgLTcsNyArNyw3IEBACiAjaWZuZGVmIF9fTUNPTlNPTEVfSF9f
CiAjZGVmaW5lIF9fTUNPTlNPTEVfSF9fCiAKLSNpZm5kZWYgX19LRVJORUxfXworI2lmZGVmIF9f
VU1fSE9TVF9fCiAjaW5jbHVkZSA8c3RkaW50Lmg+CiAjZGVmaW5lIHUzMiB1aW50MzJfdAogI2Vu
ZGlmCmRpZmYgLS1naXQgYS9hcmNoL3VtL2luY2x1ZGUvc2hhcmVkL2luaXQuaCBiL2FyY2gvdW0v
aW5jbHVkZS9zaGFyZWQvaW5pdC5oCmluZGV4IGIzOTA2ZjguLjIzM2UyNTkgMTAwNjQ0Ci0tLSBh
L2FyY2gvdW0vaW5jbHVkZS9zaGFyZWQvaW5pdC5oCisrKyBiL2FyY2gvdW0vaW5jbHVkZS9zaGFy
ZWQvaW5pdC5oCkBAIC00MCwyOCArNDAsOCBAQAogdHlwZWRlZiBpbnQgKCppbml0Y2FsbF90KSh2
b2lkKTsKIHR5cGVkZWYgdm9pZCAoKmV4aXRjYWxsX3QpKHZvaWQpOwogCi0jaWZuZGVmIF9fS0VS
TkVMX18KLSNpZm5kZWYgX19zZWN0aW9uCi0jIGRlZmluZSBfX3NlY3Rpb24oUykgX19hdHRyaWJ1
dGVfXyAoKF9fc2VjdGlvbl9fKCNTKSkpCi0jZW5kaWYKLQotI2lmIF9fR05VQ19fID09IDMKLQot
I2lmIF9fR05VQ19NSU5PUl9fID49IDMKLSMgZGVmaW5lIF9fdXNlZAkJCV9fYXR0cmlidXRlX18o
KF9fdXNlZF9fKSkKLSNlbHNlCi0jIGRlZmluZSBfX3VzZWQJCQlfX2F0dHJpYnV0ZV9fKChfX3Vu
dXNlZF9fKSkKLSNlbmRpZgotCi0jZWxzZQotI2lmIF9fR05VQ19fID09IDQKLSMgZGVmaW5lIF9f
dXNlZAkJCV9fYXR0cmlidXRlX18oKF9fdXNlZF9fKSkKLSNlbmRpZgotI2VuZGlmCi0KLSNlbHNl
CiAjaW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4KLSNlbmRpZgorCiAvKiBUaGVzZSBhcmUgZm9y
IGV2ZXJ5Ym9keSAoYWx0aG91Z2ggbm90IGFsbCBhcmNocyB3aWxsIGFjdHVhbGx5CiAgICBkaXNj
YXJkIGl0IGluIG1vZHVsZXMpICovCiAjZGVmaW5lIF9faW5pdAkJX19zZWN0aW9uKC5pbml0LnRl
eHQpCkBAIC0xMzEsNyArMTExLDcgQEAgZXh0ZXJuIHN0cnVjdCB1bWxfcGFyYW0gX191bWxfc2V0
dXBfc3RhcnQsIF9fdW1sX3NldHVwX2VuZDsKICNkZWZpbmUgX191bWxfcG9zdHNldHVwX2NhbGwJ
X191c2VkIF9fc2VjdGlvbigudW1sLnBvc3RzZXR1cC5pbml0KQogI2RlZmluZSBfX3VtbF9leGl0
X2NhbGwJCV9fdXNlZCBfX3NlY3Rpb24oLnVtbC5leGl0Y2FsbC5leGl0KQogCi0jaWZuZGVmIF9f
S0VSTkVMX18KKyNpZmRlZiBfX1VNX0hPU1RfXwogCiAjZGVmaW5lIF9fZGVmaW5lX2luaXRjYWxs
KGxldmVsLGZuKSBcCiAJc3RhdGljIGluaXRjYWxsX3QgX19pbml0Y2FsbF8jI2ZuIF9fdXNlZCBc
CmRpZmYgLS1naXQgYS9hcmNoL3VtL2luY2x1ZGUvc2hhcmVkL3VzZXIuaCBiL2FyY2gvdW0vaW5j
bHVkZS9zaGFyZWQvdXNlci5oCmluZGV4IGNlZjA2ODUuLjRjZmYxOWYgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvdW0vaW5jbHVkZS9zaGFyZWQvdXNlci5oCisrKyBiL2FyY2gvdW0vaW5jbHVkZS9zaGFyZWQv
dXNlci5oCkBAIC0xNyw3ICsxNyw3IEBACiAjZGVmaW5lIEFSUkFZX1NJWkUoeCkgKHNpemVvZih4
KSAvIHNpemVvZigoeClbMF0pKQogCiAvKiBUaGlzIGlzIHRvIGdldCBzaXplX3QgKi8KLSNpZmRl
ZiBfX0tFUk5FTF9fCisjaWZuZGVmIF9fVU1fSE9TVF9fCiAjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4KICNlbHNlCiAjaW5jbHVkZSA8c3RkZGVmLmg+CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni91bS9z
aGFyZWQvc3lzZGVwL3Rscy5oIGIvYXJjaC94ODYvdW0vc2hhcmVkL3N5c2RlcC90bHMuaAppbmRl
eCAyN2NjZTAwLi5hNjgyZGIxIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni91bS9zaGFyZWQvc3lzZGVw
L3Rscy5oCisrKyBiL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvdGxzLmgKQEAgLTEsNyArMSw3
IEBACiAjaWZuZGVmIF9TWVNERVBfVExTX0gKICNkZWZpbmUgX1NZU0RFUF9UTFNfSAogCi0jIGlm
bmRlZiBfX0tFUk5FTF9fCisjaWZkZWYgX19VTV9IT1NUX18KIAogLyogQ2hhbmdlIG5hbWUgdG8g
YXZvaWQgY29uZmxpY3RzIHdpdGggdGhlIG9yaWdpbmFsIG9uZSBmcm9tIDxhc20vbGR0Lmg+LCB3
aGljaAogICogbWF5IGJlIG5hbWVkIHVzZXJfZGVzYyAoYnV0IGluIDIuNCBhbmQgaW4gaGVhZGVy
IG1hdGNoaW5nIGl0cyBBUEkgd2FzIG5hbWVkCkBAIC0yMiwxMSArMjIsMTEgQEAgdHlwZWRlZiBz
dHJ1Y3QgdW1fZHVwX3VzZXJfZGVzYyB7CiAjZW5kaWYKIH0gdXNlcl9kZXNjX3Q7CiAKLSMgZWxz
ZSAvKiBfX0tFUk5FTF9fICovCisjZWxzZSAvKiBfX1VNX0hPU1RfXyAqLwogCiB0eXBlZGVmIHN0
cnVjdCB1c2VyX2Rlc2MgdXNlcl9kZXNjX3Q7CiAKLSMgZW5kaWYgLyogX19LRVJORUxfXyAqLwor
I2VuZGlmIC8qIF9fVU1fSE9TVF9fICovCiAKIGV4dGVybiBpbnQgb3Nfc2V0X3RocmVhZF9hcmVh
KHVzZXJfZGVzY190ICppbmZvLCBpbnQgcGlkKTsKIGV4dGVybiBpbnQgb3NfZ2V0X3RocmVhZF9h
cmVhKHVzZXJfZGVzY190ICppbmZvLCBpbnQgcGlkKTsK
--bcaec51b1a477d5a500516db2fd9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
--bcaec51b1a477d5a500516db2fd9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--bcaec51b1a477d5a500516db2fd9--


