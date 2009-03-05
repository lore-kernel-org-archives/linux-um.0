Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bharrosh@panasas.com>) id 1LfE5c-00081W-Fj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 13:58:20 +0000
Received: from gw-ca.panasas.com ([209.116.51.66] helo=laguna.int.panasas.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LfE5Z-00042R-Fo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 13:58:20 +0000
Message-ID: <49AFD780.8080500@panasas.com>
Date: Thu, 05 Mar 2009 15:45:36 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <49AFC206.9080004@panasas.com> <20090305130610.GA4265@hack.private>
In-Reply-To: <20090305130610.GA4265@hack.private>
Subject: Re: [uml-devel] um: WARNING: vmlinux: 'memcpy' exported twice.
 Previous export was in vmlinux
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

QW3DqXJpY28gV2FuZyB3cm90ZToKPiBPbiBUaHUsIE1hciAwNSwgMjAwOSBhdCAwMjoxMzo1OFBN
ICswMjAwLCBCb2F6IEhhcnJvc2ggd3JvdGU6Cj4+IE9uIHRvZGF5J3MgbGludXMgdjIuNi4yOS1y
YzctMy1nNTU5NTk1YQo+Pgo+PiBEb2luZyBtYWtlIEFSQ0g9dW0gZGVmY29uZmlnICYgbWFrZSBB
UkNIPXVtCj4+IGdpdmUncyBtZToKPj4KPj4gTEQgdm1saW51eC5vCj4+IE1PRFBPU1Qgdm1saW51
eC5vCj4+IFdBUk5JTkc6IHZtbGludXg6ICdtZW1jcHknIGV4cG9ydGVkIHR3aWNlLiBQcmV2aW91
cyBleHBvcnQgd2FzIGluIHZtbGludXgKPj4KPj4KPj4gU29ycnkgaWYgdGhpcyBpcyBhIGR1cGxp
Y2F0ZSByZXBvcnQKPj4KPiAKPiBXZWlyZC4uLgo+IEkgdHJpZWQgdG8gY29tcGlsZSBsaWtlIHdo
YXQgeW91IHNhaWQsIEkgY2FuJ3QgcmVwcm9kdWNlIGl0Lgo+IAo+IFdoaWNoIGdjYyBhcmUgeW91
IHVzaW5nPwo+IAo+IFRoYW5rcy4KPiAKCiQgZ2NjIC0tdmVyc2lvbgpnY2MgKEdDQykgNC4zLjIg
MjAwODExMDUgKFJlZCBIYXQgNC4zLjItNykKCkknbSBydW5uaW5nIG9uIGFuIHg4Nl82NCBGZWRv
cmExMCBzeXN0ZW0gKHVwZGF0ZWQgcmVjZW50bHkpCiQgdW5hbWUgLW8gLXMgLXIgLW0gLXAgLWkK
TGludXggMi42LjI3LjE1LTE3MC4yLjI0LmZjMTAueDg2XzY0IHg4Nl82NCB4ODZfNjQgeDg2XzY0
IEdOVS9MaW51eAoKVGhhbmtzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KT3BlbiBTb3VyY2UgQnVz
aW5lc3MgQ29uZmVyZW5jZSAoT1NCQyksIE1hcmNoIDI0LTI1LCAyMDA5LCBTYW4gRnJhbmNpc2Nv
LCBDQQotT1NCQyB0YWNrbGVzIHRoZSBiaWdnZXN0IGlzc3VlIGluIG9wZW4gc291cmNlOiBPcGVu
IFNvdXJjaW5nIHRoZSBFbnRlcnByaXNlCi1TdHJhdGVnaWVzIHRvIGJvb3N0IGlubm92YXRpb24g
YW5kIGN1dCBjb3N0cyB3aXRoIG9wZW4gc291cmNlIHBhcnRpY2lwYXRpb24KLVJlY2VpdmUgYSAk
NjAwIGRpc2NvdW50IG9mZiB0aGUgcmVnaXN0cmF0aW9uIGZlZSB3aXRoIHRoZSBzb3VyY2UgY29k
ZTogU0ZBRApodHRwOi8vcC5zZi5uZXQvc2Z1L1hjdk16RjhICl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5n
IGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2
ZWwK

