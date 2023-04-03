defmodule Premailex.HTMLToPlainTextTest do
  use ExUnit.Case
  doctest Premailex.HTMLToPlainText

  @input """
  <h1>Heading 1</h1>
  <h1>Heading<br/>with <br /><span>HTML</span></h1>
  <h2>Heading 2</h2>
  <h3>Heading 3</h3>

  <p><a href="http://example.com">Example link</a></p>
  <p><a href="http://example.com">http://example.com</a></p>
  <p><a href="http://example.com">HTTP://EXAMPLE.COM</a></p>
  <p><a href="http://example.com"></a></p>
  <p><span>Test</span> some very long paragraph with <strong>bold</strong> and <i>italic</i> text, including an <a href="http://example.com">inline link</a>. This should break up on multiple lines.</p>
  <p><span>Test</span>   <strong>consecutive</strong> <i>tags</i>.</p>

  <hr />

  <img href="logo.png" alt="Test image" /><br/>
  <img href="logo.png" /><br/>

  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
  </ul>
  <ol>
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
  </ol>

  <p>HTML entities: &amp; &copy;</p>
  <p>        Paragraph with space        </p>
  <p>
    Doesn't break URL: http://www.example.com/this-is-a-very-long-uri-to-verify-that-wordwrap-breaks-will-not-break-this-url
    <a href="http://www.example.com/this-is-a-very-long-uri-to-verify-that-wordwrap-breaks-will-not-break-this-url">Paranthesis test</a>
  </p>

  <table>
    <thead>
      <tr>
        <th>thead key</th>
        <th>thead value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>tbody key</td>
        <td>tbody value</td>
      </tr>
    </tbody>
    <tbody>
      <tr>
        <td>tbody key 2</td>
        <td>tbody value 2</td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <td>tfoot key</td>
        <td>tfoot value</td>
      </tr>
    </tfoot>
    <tr>
      <th>Header key</th>
      <th>Header value</th>
    </tr>
    <tr>
      <td>Key:</td>
      <td>Value</td>
    </tr>
    <tr>
      <td>Key 2:</td>
      <td>
        <table>
          <!-- This is a comment -->
          <tr>
            <td>Nested key:</td>
            <td>Value</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <!--[if (gte mso 9)|(IE)]>
  <p>Downlevel-hidden comment</p>
  <![endif]-->

  <!--[if !mso]><!-- -->
  <p>Downlevel-revealed comment</p>
  <!--<![endif]-->

  <!-- This is a comment -->
  """

  @parsed """
  *********
  Heading 1
  *********

  *******
  Heading
  with
  HTML
  *******

  ---------
  Heading 2
  ---------

  Heading 3
  ---------

  Example link (http://example.com)

  http://example.com

  http://example.com

  Test some very long paragraph with bold and italic text,
  including an inline link (http://example.com). This should break
  up on multiple lines.

  Test consecutive tags.

  -----------------------------------------------------------------

  Test image

  * Item 1
  * Item 2
  * Item 3
  1. Item 1
  2. Item 2
  3. Item 3
  HTML entities: & ©

  Paragraph with space

  Doesn't break URL:
  http://www.example.com/this-is-a-very-long-uri-to-verify-that-wordwrap-breaks-will-not-break-this-url
  Paranthesis test
  (http://www.example.com/this-is-a-very-long-uri-to-verify-that-wordwrap-breaks-will-not-break-this-url)

  thead key thead value
  tbody key tbody value
  tbody key 2 tbody value 2
  tfoot key tfoot value
  Header key Header value
  Key: Value
  Key 2: Nested key: Value

  Downlevel-revealed comment
  """

  test "process/1" do
    assert Premailex.HTMLToPlainText.process(@input) == String.trim(@parsed)
  end
end
