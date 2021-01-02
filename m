Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kvhVd-0005wq-CN
 for linux-um@lists.infradead.org; Sat, 02 Jan 2021 14:03:58 +0000
Received: by mail-wr1-x435.google.com with SMTP id r3so26492105wrt.2
 for <linux-um@lists.infradead.org>; Sat, 02 Jan 2021 06:03:54 -0800 (PST)
Received: from ?IPv6:2a02:c7f:488e:de00:f7c6:fee1:4d55:b3b3?
 ([2a02:c7f:488e:de00:f7c6:fee1:4d55:b3b3])
 by smtp.gmail.com with ESMTPSA id b14sm78263428wrx.77.2021.01.02.06.03.52
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Jan 2021 06:03:52 -0800 (PST)
From: Joshua Hawking <joshuahawking1@gmail.com>
Subject: [PATCH] um: Fix null pointer dereference when parsing ubd commandline
 arguments
Message-ID: <0c7b460e-1929-bf42-2ade-f99f97d45428@gmail.com>
Date: Sat, 2 Jan 2021 14:03:52 +0000
MIME-Version: 1.0
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

RnJvbTogQWRhbSBXYXRzb24gKGF3NDE0MTQxQGdtYWlsLmNvbSkKCldoZW4gcGFzc2luZyBvbmUg
b3IgdHdvIGFyZ3VtZW50cyB0byB1YmQgZHVyaW5nIFVNTCBzZXR1cCAtIGkuZS4KdWJkMD1GaWxl
IG9yIHViZDA9RmlsZSxCYWNraW5nX0ZpbGUgLSB0aGUgcGFyc2luZyBjb2RlIGludHJvZHVjZWQg
aW4gY29tbWl0CmVmM2JhODdjYjdjOSAoInVtOiB1YmQ6IFNldCBkZXZpY2Ugc2VyaWFsIGF0dHJp
YnV0ZSBmcm9tIGNtZGxpbmUiKSBkb2VzCm5vdCBjaGVjawp3aGV0aGVyIHN0cnNlcCBjb25zdW1l
ZCB0aGUgZW50aXJlIHN0cmluZyB3aXRob3V0IGZpbmRpbmcgYSBkZWxpbWV0ZXIKbGFzdCB0aW1l
Cml0IHdhcyBjYWxsZWQgKGFuZCBzbyBoYXMgc2V0IHN0ciB0byBOVUxMLCBjYXVzaW5nIHRoZSBu
ZXh0IG91dHB1dCBvZiBzdHJzZXAKb24gdGhhdCBzdHJpbmcgdG8gYmUgTlVMTCkgYmVmb3JlIGF0
dGVtcHRpbmcgdG8gZGVyZWZlcmVuY2UgdGhlIG91dHB1dCBvZiBpdAppbnNpZGUgdGhlIGlmIHN0
YXRlbWVudHMuIEZvciBleGFtcGxlLCB3aXRoIHR3byBhcmd1bWVudHMgKGFuZCBvbmx5IDEKY29t
bWEvY29sb24pLCBzZXJpYWwgd2lsbCBiZSBOVUxMLCBhbmQgKCpzZXJpYWwgPT0gJ1wwJykgY2F1
c2VzIGEgbnVsbApwb2ludGVyCmRlcmVmZXJlbmNlLgoKU2lnbmVkLW9mZi1ieTogQWRhbSBXYXRz
b24gKGF3NDE0MTQxQGdtYWlsLmNvbSkKU2lnbmVkLW9mZi1ieTogSm9zaHVhIEhhd2tpbmcgKGpv
c2h1YWhhd2tpbmcxQGdtYWlsLmNvbSkKVGVzdGVkLWJ5OiBKb3NodWEgSGF3a2luZyAoam9zaHVh
aGF3a2luZzFAZ21haWwuY29tKQpGaXhlczogZWYzYmE4N2NiN2M5ICgidW06IHViZDogU2V0IGRl
dmljZSBzZXJpYWwgYXR0cmlidXRlIGZyb20gY21kbGluZSIpCi0tLQotLS0gYi9hcmNoL3VtL2Ry
aXZlcnMvdWJkX2tlcm4uY8KgwqAgwqAyMDIxLTAxLTAyIDEzOjEzOjU1Ljk5NTAxODk0MiArMDAw
MAorKysgYS9hcmNoL3VtL2RyaXZlcnMvdWJkX2tlcm4uY8KgwqAgwqAyMDIxLTAxLTAyIDEzOjE2
OjE2Ljg0NzAyMzkwNSArMDAwMApAQCAtMzc1LDExICszNzUsMTEgQEAgYnJlYWtfbG9vcDoKwqDC
oMKgIMKgwqDCoCDCoGZpbGUgPSBOVUxMOwrCoArCoMKgwqAgwqBiYWNraW5nX2ZpbGUgPSBzdHJz
ZXAoJnN0ciwgIiw6Iik7Ci3CoMKgIMKgaWYgKCpiYWNraW5nX2ZpbGUgPT0gJ1wwJykKK8KgwqAg
wqBpZiAoYmFja2luZ19maWxlICYmICpiYWNraW5nX2ZpbGUgPT0gJ1wwJykKwqDCoMKgIMKgwqDC
oCDCoGJhY2tpbmdfZmlsZSA9IE5VTEw7CsKgCsKgwqDCoCDCoHNlcmlhbCA9IHN0cnNlcCgmc3Ry
LCAiLDoiKTsKLcKgwqAgwqBpZiAoKnNlcmlhbCA9PSAnXDAnKQorwqDCoCDCoGlmIChzZXJpYWwg
JiYgKnNlcmlhbCA9PSAnXDAnKQrCoMKgwqAgwqDCoMKgIMKgc2VyaWFsID0gTlVMTDsKwqAKwqDC
oMKgIMKgaWYgKGJhY2tpbmdfZmlsZSAmJiB1YmRfZGV2LT5ub19jb3cpIHsKCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

