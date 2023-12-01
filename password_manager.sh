#!/bin/bash
# ループ内でユーザーにメニューを表示,選択肢に応じて処理を行う
while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    # ユーザーからの入力を取得、choice変数に代入
    read choice

    case $choice in
        "Add Password")
            read -p "サービス名を入力してください: " serviceName
            read -p "ユーザー名を入力してください: " userName
            read -p  "パスワードを入力してください: " password
            # 入力された情報をpasswords.txtファイルに追記
            echo "$serviceName:$userName:$password" >> passwords.txt
            echo "パスワードの追加は成功しました。"
            ;;
        "Get Password")
            read -p "サービス名を入力してください: " serviceName
            # serviceNameに対応するpassをpasswords.txtファイルから取得
            password=$(grep "^$serviceName:" passwords.txt | cut -d: -f3)

            if [ -z "$password" ]; then
                echo "そのサービスは登録されていません。"
            else
                echo "サービス名：$serviceName"
                # サービス名に対応するユーザー名を表示
                echo "ユーザー名：$(grep "^$serviceName:" passwords.txt | cut -d: -f2 )"
                # サービス名に対応するパスワードを表示
                echo "パスワード：$password"
            fi
            ;;
        "Exit")
            echo "Thank you!"
            exit
            ;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
            ;;
    esac
done
