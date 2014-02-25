Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Tue, 25 Feb 2014 18:16:23 +0900
Message-Id: <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Subject: [PATCH v2 0/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
To: viro@zeniv.linux.org.uk, eparis@redhat.com, rgb@redhat.com, arndb@arndb.de
Cc: linux-s390@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-alpha@vger.kernel.org, dsaxena@linaro.org, user-mode-linux-user@lists.sourceforge.net, linux-audit@redhat.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Q3VycmVudGx5IEFVRElUU1lTQ0FMTCBoYXMgYSBsb25nIGxpc3Qgb2YgYXJjaGl0ZWN0dXJlIGRl
cGVuY2VuY3k6CiAgICAgICBkZXBlbmRzIG9uIEFVRElUICYmIChYODYgfHwgUEFSSVNDIHx8IFBQ
QyB8fCBTMzkwIHx8IElBNjQgfHwgVU1MIHx8CiAgICAgICAgICAgICAgICBTUEFSQzY0IHx8IFNV
UEVSSCB8fCAoQVJNICYmIEFFQUJJICYmICFPQUJJX0NPTVBBVCkgfHwgQUxQSEEpClRoZSBwdXJw
b3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gcmVwbGFjZSBpdCB3aXRoIEhBVkVfQVJDSF9BVURJVFNZ
U0NBTEwKZm9yIHNpbXBsaWNpdHkuCgpDaGFuZ2VzIHYxIC0+IHYyOgoqIHJlYmFzZWQgdG8gMy4x
NC1yY1gsIGFuZCBzbyBhZGRlZCBhIGNoYW5nZSBvbiBBTFBIQQoKQUtBU0hJIFRha2FoaXJvICgx
KToKICBhdWRpdDogQWRkIENPTkZJR19IQVZFX0FSQ0hfQVVESVRTWVNDQUxMCgogYXJjaC9hbHBo
YS9LY29uZmlnICAgICB8ICAgIDEgKwogYXJjaC9hcm0vS2NvbmZpZyAgICAgICB8ICAgIDEgKwog
YXJjaC9pYTY0L0tjb25maWcgICAgICB8ICAgIDEgKwogYXJjaC9wYXJpc2MvS2NvbmZpZyAgICB8
ICAgIDEgKwogYXJjaC9wb3dlcnBjL0tjb25maWcgICB8ICAgIDEgKwogYXJjaC9zMzkwL0tjb25m
aWcgICAgICB8ICAgIDEgKwogYXJjaC9zaC9LY29uZmlnICAgICAgICB8ICAgIDEgKwogYXJjaC9z
cGFyYy9LY29uZmlnICAgICB8ICAgIDEgKwogYXJjaC91bS9LY29uZmlnLmNvbW1vbiB8ICAgIDEg
KwogYXJjaC94ODYvS2NvbmZpZyAgICAgICB8ICAgIDEgKwogaW5pdC9LY29uZmlnICAgICAgICAg
ICB8ICAgIDUgKysrKy0KIDExIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCi0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1k
ZXY=

