Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH] um: Add missing "FORCE" target when using if_changed
References: <20211008215133.9371-1-rdunlap@infradead.org>
 <CABVgOS=QVysVtN5seB5hp7hHAw5P0yuOaA3rgkRtEyiJu-1H6Q@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05939461-793d-2266-8752-1b593bab8eec@infradead.org>
Date: Fri, 8 Oct 2021 17:01:12 -0700
MIME-Version: 1.0
In-Reply-To: <CABVgOS=QVysVtN5seB5hp7hHAw5P0yuOaA3rgkRtEyiJu-1H6Q@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, x86@kernel.org

On 10/8/21 4:23 PM, David Gow wrote:
> On Sat, Oct 9, 2021 at 5:51 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> 'make ARCH=um' says:
>>
>> ../arch/x86/um/Makefile:44: FORCE prerequisite is missing
>>
>> and adding "FORCE" there makes it be quiet, so do it.  :)
>>
>> Fixes: e1f86d7b4b2a ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: linux-kbuild@vger.kernel.org
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: linux-um@lists.infradead.org
>> Cc: x86@kernel.org
>> ---
> 
> FYI, this looks identical to "uml: x86: add FORCE to user_constants.h":
> http://lists.infradead.org/pipermail/linux-um/2021-September/001791.html

Oh, thanks for that.

Maintainers?...

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

