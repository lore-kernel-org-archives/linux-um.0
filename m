Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
References: <20170524003232.14319-1-f.fainelli@gmail.com>
 <e2c13a8b-d0c3-74d1-dd1b-53a56f609c76@nod.at>
 <9f58b41d-ebe4-62a6-1aa4-e9222372ce86@gmail.com>
 <408132c9-6d55-7cba-e09a-f532d7fb9c6f@gmail.com>
 <9617f203-cee2-96cf-aa76-8f42b1a4a9f6@nod.at>
 <2c362d49-9907-7a66-67ef-e196dddea32a@gmail.com>
 <85f8b8c0-cf0e-3c67-c237-be4b045c617b@nod.at>
 <f57b5906-30cc-0fdf-893c-39e4f5202d1b@gmail.com>
 <07b61d6a-33af-be0a-b57c-843196d0d151@nod.at>
 <8dd50867-312d-8af9-0993-4b5d5c181a58@gmail.com>
 <e53ebfee-0b8a-0fe6-c2d3-eb6fb4aa9e2c@nod.at>
 <1496352322.9072.1.camel@m3y3r.de>
 <3672f56d-da81-1114-f06a-ac99d3680661@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <0effc7cf-7a86-bed6-58cf-d8fd6d3febd6@nod.at>
Date: Fri, 2 Jun 2017 09:38:45 +0200
MIME-Version: 1.0
In-Reply-To: <3672f56d-da81-1114-f06a-ac99d3680661@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thomas,

Am 02.06.2017 um 07:49 schrieb Florian Fainelli:
>> the put_fp_registers fails with errno 4 if I recall correctly.
>>
>> I didn't investigate yet further, why the the xstate ptrace call fails.
> 
> Which of the branches is put_fp_registers() taking? The
> restore_fpx_registers() or restore_fp_registers()? 4 would be EINTR...
> What kernel version is used on your host running the UML binary?

Another question, is this x86_64 UML on a x86_64 host?
Or i386 on x86_64, i386 on i386?

Thanks,
//richard

