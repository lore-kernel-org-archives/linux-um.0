Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1dze7K-0001aI-MS for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 07:29:18 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dze7I-0003hn-PM
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 07:29:18 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
 helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1dze7B-0002RL-Rx for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 07:29:09 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dze7B-0006w3-HS
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 04 Oct 2017 08:29:09 +0100
References: <20170926102653.10822-1-anton.ivanov@kot-begemot.co.uk>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <a18857e4-b99e-ad0c-2652-33ac59f371ab@kot-begemot.co.uk>
Date: Wed, 4 Oct 2017 08:29:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170926102653.10822-1-anton.ivanov@kot-begemot.co.uk>
Content-Language: en-US
Subject: Re: [uml-devel] Patch v3
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

SSBnb3QgdGhlIFRTTyBhbmQgc29tZSBvZmZsb2FkcyB3b3JraW5nIGZvciBzb21lIChub3QgYWxs
KSBjYXNlcyBvZiBteSAKcGF0Y2hzZXRzLgoKUHJlbGltaW5hcnkgc3BlZWRzIGFuZCBmZWVkcyBv
biBpcGVyZjoKClvCoCA0XSBsb2NhbCAxOTIuMTY4Ljk4LjEgcG9ydCA1MDAxIGNvbm5lY3RlZCB3
aXRoIDE5Mi4xNjguOTguMTMyIHBvcnQgNTQ4MzgKW8KgIDRdwqAgMC4wLTEwLjAgc2VjwqAgNC43
OCBHQnl0ZXPCoCA0LjExIEdiaXRzL3NlYwoKQXMgYSBjb21wYXJpc29uIC0ga3ZtL3FlbXUgb24g
c2FtZSBtYWNoaW5lIGRvZXMgYWJvdXQgYSBHYml0IGFuZCB2RXRoIHRvIApjb250YWluZXIgZG9l
cyAyMEdiaXQgLSBzbyBzb21ld2hlcmUgaW4gYmV0d2Vlbi4KCkkgYW0gaGF2aW5nIHNvbWUgdHJv
dWJsZSB3aXRoIFRTTyBhbmQgcmF3IHNvY2tldHMuIE9uY2UgSSBmaWd1cmUgb3V0IAp3aGF0IGlz
IGdvaW5nIG9uIChhbmQgaG9wZWZ1bGx5IGZpeCBpdCkgdGhlcmUgd2lsbCBiZSBhbiB1cGRhdGVk
IHZlcnNpb24gCndoaWNoIHNob3VsZCB0YWtlIHVzIGludG8gNHggd2hhdCBrdm0vUUVNVSBkb2Vz
IG9uIG9uZSBDUFUgbmV0d29ya3dpc2UuCgpBLgoKCk9uIDA5LzI2LzE3IDExOjI2LCBhbnRvbi5p
dmFub3ZAa290LWJlZ2Vtb3QuY28udWsgd3JvdGU6Cj4gSGkgTGlzdCwgaGkgUmljaGFyZCwKPgo+
IEkgZm91bmQgYSBsb2dpY2FsIGVycm9yIGluIHRoZSBTRyBjb2RlLiBUaGlzIHJldmlzaW9uIGZp
eGVzIHRoYXQuIE5vCj4gb3RoZXIgY2hhbmdlcyAtIHRoZSByZXN0IGFwcGVhcnMgdG8gd29yayBh
cyBpdCBzaG91bGQgaW4gbXkgdGVzdGluZy4KPgo+IEJyZ2RzLAo+Cj4gQS4KPgo+Cj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4gQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9u
IG9uZSBvZiB0aGUgd29ybGQncyBtb3N0Cj4gZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qu
b3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IFVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRl
dmVsCj4KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2gg
Y29tbXVuaXR5IG9uIG9uZSBvZiB0aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMs
IFNsYXNoZG90Lm9yZyEgaHR0cDovL3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWls
aW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgt
ZGV2ZWwK

