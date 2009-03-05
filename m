Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LfG3u-0003UW-IL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 16:04:42 +0000
Received: from ti-out-0910.google.com ([209.85.142.187])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LfG3l-0000He-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 16:04:42 +0000
Received: by ti-out-0910.google.com with SMTP id a6so3925408tib.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 05 Mar 2009 08:04:32 -0800 (PST)
Date: Fri, 6 Mar 2009 00:04:47 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090305160447.GB4265@hack.private>
References: <49AFC206.9080004@panasas.com> <20090305130610.GA4265@hack.private>
	<49AFD780.8080500@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49AFD780.8080500@panasas.com>
Subject: Re: [uml-devel] um: WARNING: vmlinux: 'memcpy' exported twice.
	Previous export	was in vmlinux
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gVGh1LCBNYXIgMDUsIDIwMDkgYXQgMDM6NDU6MzZQTSArMDIwMCwgQm9heiBIYXJyb3NoIHdy
b3RlOgo+QW3DqXJpY28gV2FuZyB3cm90ZToKPj4gT24gVGh1LCBNYXIgMDUsIDIwMDkgYXQgMDI6
MTM6NThQTSArMDIwMCwgQm9heiBIYXJyb3NoIHdyb3RlOgo+Pj4gT24gdG9kYXkncyBsaW51cyB2
Mi42LjI5LXJjNy0zLWc1NTk1OTVhCj4+Pgo+Pj4gRG9pbmcgbWFrZSBBUkNIPXVtIGRlZmNvbmZp
ZyAmIG1ha2UgQVJDSD11bQo+Pj4gZ2l2ZSdzIG1lOgo+Pj4KPj4+IExEIHZtbGludXgubwo+Pj4g
TU9EUE9TVCB2bWxpbnV4Lm8KPj4+IFdBUk5JTkc6IHZtbGludXg6ICdtZW1jcHknIGV4cG9ydGVk
IHR3aWNlLiBQcmV2aW91cyBleHBvcnQgd2FzIGluIHZtbGludXgKPj4+Cj4+Pgo+Pj4gU29ycnkg
aWYgdGhpcyBpcyBhIGR1cGxpY2F0ZSByZXBvcnQKPj4+Cj4+IAo+PiBXZWlyZC4uLgo+PiBJIHRy
aWVkIHRvIGNvbXBpbGUgbGlrZSB3aGF0IHlvdSBzYWlkLCBJIGNhbid0IHJlcHJvZHVjZSBpdC4K
Pj4gCj4+IFdoaWNoIGdjYyBhcmUgeW91IHVzaW5nPwo+PiAKPj4gVGhhbmtzLgo+PiAKPgo+JCBn
Y2MgLS12ZXJzaW9uCj5nY2MgKEdDQykgNC4zLjIgMjAwODExMDUgKFJlZCBIYXQgNC4zLjItNykK
Pgo+SSdtIHJ1bm5pbmcgb24gYW4geDg2XzY0IEZlZG9yYTEwIHN5c3RlbSAodXBkYXRlZCByZWNl
bnRseSkKPiQgdW5hbWUgLW8gLXMgLXIgLW0gLXAgLWkKPkxpbnV4IDIuNi4yNy4xNS0xNzAuMi4y
NC5mYzEwLng4Nl82NCB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgKPgoKSSBhbSB1c2lu
ZyB0aGUgc2FtZSB0aGluZywgYnV0IG9uIGkzODYuIEkgc3RpbGwgY2FuJ3QgcmVwcm9kdWNlIGl0
LiA6KAoKLS0gCkRvIHdoYXQgeW91IGxvdmUsIGYqKmsgdGhlIHJlc3QhIEYqKmsgdGhlIHJlZ3Vs
YXRpb25zIQogCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KT3BlbiBTb3VyY2UgQnVzaW5lc3MgQ29u
ZmVyZW5jZSAoT1NCQyksIE1hcmNoIDI0LTI1LCAyMDA5LCBTYW4gRnJhbmNpc2NvLCBDQQotT1NC
QyB0YWNrbGVzIHRoZSBiaWdnZXN0IGlzc3VlIGluIG9wZW4gc291cmNlOiBPcGVuIFNvdXJjaW5n
IHRoZSBFbnRlcnByaXNlCi1TdHJhdGVnaWVzIHRvIGJvb3N0IGlubm92YXRpb24gYW5kIGN1dCBj
b3N0cyB3aXRoIG9wZW4gc291cmNlIHBhcnRpY2lwYXRpb24KLVJlY2VpdmUgYSAkNjAwIGRpc2Nv
dW50IG9mZiB0aGUgcmVnaXN0cmF0aW9uIGZlZSB3aXRoIHRoZSBzb3VyY2UgY29kZTogU0ZBRApo
dHRwOi8vcC5zZi5uZXQvc2Z1L1hjdk16RjhICl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNl
ci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

